function glances
    set -lx TZ Europe/Berlin
    docker run --rm -e TZ="$TZ" -v /var/run/docker.sock:/var/run/docker.sock:ro --pid host --network host -it nicolargo/glances:4.3.3-full
end
