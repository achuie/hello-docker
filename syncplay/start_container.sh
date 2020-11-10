#!/usr/bin/env sh

docker run --rm -it --name syncplay \
    --hostname syncplay \
    --ipc=host \
    -v /etc/shadow:/etc/shadow:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -v /tmp/.X11-unix/X1:/tmp/.X11-unix/X1:rw \
    -e DISPLAY=$DISPLAY \
    -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    syncplay
