#!/usr/bin/env sh

docker run --rm -it --name hello_docker \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    --hostname hello_docker \
    -v /etc/shadow:/etc/shadow:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    hello_docker
