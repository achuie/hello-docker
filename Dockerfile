FROM archlinux:latest

RUN pacman -Syu --needed --noconfirm base-devel zsh git reflector && \
    reflector --verbose --latest 40 --number 10 --sort rate --protocol http \
    --save /etc/pacman.d/mirrorlist

RUN useradd -m builduser && \
    passwd -d builduser

RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers

RUN sudo -u builduser zsh -c 'mkdir ~/pkg-builds && \
    cd ~/pkg-builds && \
    git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si --noconfirm'

RUN sudo -u builduser zsh -c \
    'yay -S --needed --noconfirm ros-noetic-ros-base'

RUN rosdep init && \
    rosdep update

RUN git clone https://www.github.com/achuie/dotfiles.git && \
    echo 'export ZDOTDIR=/etc/zsh' | tee /etc/zsh/zshenv && \
    cp /dotfiles/.zsh/.zshrc /etc/zsh/zshrc && \
    echo 'source /opt/ros/noetic/setup.zsh' | tee -a /etc/zsh/zshrc && \
    cp -r /dotfiles/.zsh/prompts /etc/zsh/prompts && \
    mkdir /etc/zsh/functions && \
    ln -s /etc/zsh/prompts/achuie.zsh /etc/zsh/functions/prompt_achuie_setup

RUN userdel -r builduser

CMD ["/usr/bin/zsh"]
