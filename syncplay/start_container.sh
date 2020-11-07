#!/usr/bin/env sh

docker run --rm -it --name syncplay \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    --hostname syncplay \
    -v /etc/shadow:/etc/shadow:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -v /home/achuie:/home/achuie \
    -v /tmp/.X11-unix/X1:/tmp/.X11-unix/X1 \
    -e DISPLAY=:1 \
    -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    syncplay
