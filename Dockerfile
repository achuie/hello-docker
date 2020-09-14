FROM archlinux:latest

RUN pacman -Syu --noconfirm zsh git sudo

RUN useradd builduser -m && \
    passwd -d builduser

RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers

#RUN sudo -u builduser zsh -c 'mkdir ~/pkg-builds && \
#    cd ~/pkg-builds && \
#    git clone https://aur.archlinux.org/ros-noetic-desktop-full.git && \
#    cd ros-noetic-desktop-full && \
#    makepkg -s --noconfirm'

#RUN pacman -U --noconfirm /home/builduser/pkg-builds/*/*.pkg.tar.*

#RUN rosdep init && \
#    rosdep update

CMD ["/usr/bin/zsh"]
