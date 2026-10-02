#!/usr/bin/env python3
"""Offline checks; use isolated Fish state and remove only test-created kube files."""
from pathlib import Path
import os
import shutil
import subprocess
import tempfile

home = Path.home()
fish_dir = home / '.config/fish'
fish = shutil.which('fish')
assert fish, 'fish is required'
files = [fish_dir / 'config.fish', fish_dir / 'tide-settings.fish',
         fish_dir / 'conf.d/environment.fish', fish_dir / 'conf.d/aliases.fish',
         home / '.local/bin/system-info.fish']
files += [fish_dir / 'functions' / f'{name}.fish' for name in
          ('aws-mfa', 'aws-mfa-clear', 'gitdiff', 'preview', 'glances', 'fuck', 'fish_user_key_bindings')]
for file in files:
    subprocess.run([fish, '--no-config', '--no-execute', str(file)], check=True)

with tempfile.TemporaryDirectory(prefix='dotfiles-check-') as tmp:
    env = dict(os.environ, XDG_CONFIG_HOME=tmp)
    for key in ('KCONFDIR', 'KUBECONFIG'):
        env.pop(key, None)
    def run(script, **extra):
        return subprocess.run([fish, '--no-config', '-c', script],
                              env=dict(env, **extra), capture_output=True, text=True, check=True).stdout.strip()
    source = f'source "{fish_dir}/conf.d/environment.fish"; or exit 1; '
    created = []
    try:
        for _ in range(2):
            created.append(Path(run(source + 'printf "%s" "$KCONFDIR"')))
        assert created[0] != created[1], 'Independent shells must get different kubeconfigs'
        first = created[0]
        assert (first / 'me').read_text().strip().isdigit()
        config = first / 'kubeconfig'
        config.write_text('# preserve existing config\n')
        output = run(source + 'printf "%s" "$KUBECONFIG"', KCONFDIR=str(first))
        assert output == str(config)
        assert config.read_text() == '# preserve existing config\n'
        missing = subprocess.run([fish, '--no-config', '-c', source],
                                 env=dict(env, KCONFDIR=tmp + '/missing'), capture_output=True)
        assert missing.returncode != 0, 'Invalid inherited directory must fail'
        guard = run(f'source "{fish_dir}/functions/aws-mfa.fish"; '
                    'set -e DOTFILES_AWS_PROFILE; set -e DOTFILES_AWS_MFA_ARN; '
                    'aws-mfa 2>/dev/null; test $status -eq 1; or exit 1')
        run(f'source "{fish_dir}/tide-settings.fish"; '
            'test "$tide_left_prompt_items[1]" = os; or exit 1; '
            'source "' + str(fish_dir) + '/conf.d/aliases.fish"; '
            'functions ls | string match -q "*eza*"; or exit 1')
    finally:
        for directory in created:
            assert directory.parent == Path('/tmp/kubes')
            shutil.rmtree(directory)
print('PASS: Fish syntax, isolated appearance/aliases, kubeconfig isolation/inheritance, AWS local-settings guard')
