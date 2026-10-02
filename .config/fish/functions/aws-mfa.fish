function aws-mfa
    set -l profile "$DOTFILES_AWS_PROFILE"
    set -l mfa_arn "$DOTFILES_AWS_MFA_ARN"
    if test -z "$profile"; or test -z "$mfa_arn"
        echo "Set DOTFILES_AWS_PROFILE and DOTFILES_AWS_MFA_ARN in local.fish" >&2
        return 1
    end

    # Prevent stale environment credentials from overriding the base profile
    set -e AWS_ACCESS_KEY_ID
    set -e AWS_SECRET_ACCESS_KEY
    set -e AWS_SESSION_TOKEN

    read -P "MFA code: " token

    set -l response (
        aws sts get-session-token \
            --profile "$profile" \
            --serial-number "$mfa_arn" \
            --token-code "$token" \
            --output json
    )

    if test $status -ne 0
        echo "Failed to obtain AWS session credentials"
        return 1
    end

    set -l credentials (
        printf '%s\n' "$response" |
            jq -r '
                .Credentials.AccessKeyId,
                .Credentials.SecretAccessKey,
                .Credentials.SessionToken,
                .Credentials.Expiration
            '
    )

    if test (count $credentials) -ne 4
        echo "Failed to parse AWS session credentials"
        return 1
    end

    set -gx AWS_ACCESS_KEY_ID "$credentials[1]"
    set -gx AWS_SECRET_ACCESS_KEY "$credentials[2]"
    set -gx AWS_SESSION_TOKEN "$credentials[3]"

    echo "AWS MFA session active until $credentials[4]"
    aws sts get-caller-identity
end
