FROM archlinux:latest

RUN pacman -Syu --needed --noconfirm base-devel zsh git

RUN useradd builduser -m && \
    passwd -d builduser

RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers

RUN sudo -u builduser zsh -c 'mkdir ~/pkg-builds && \
    cd ~/pkg-builds && \
    git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si --noconfirm'

#RUN pacman -U --noconfirm /home/builduser/pkg-builds/yay/*.pkg.tar.*

RUN sudo -u builduser zsh -c \
    'yay -S --needed --noconfirm ros-noetic-ros-base'

RUN rosdep init && \
    rosdep update

CMD ["/usr/bin/zsh"]
