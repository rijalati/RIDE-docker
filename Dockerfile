from base/arch

MAINTAINER rijalati@gmail.com

RUN [ -d /etc/pacman.d ] || mkdir -p /etc/pacman.d

RUN pacman -Syy
RUN pacman -S --noconfirm archlinux-keyring
RUN pacman -Syu -y --needed --noconfirm --force
RUN pacman-db-upgrade
RUN pacman -Syu --noconfirm --needed \
    base-devel \
    python2 \
    wxgtk2.8 \
    curl \
    git \
    wxpython2.8 \
    bash \
    python2-pip \
    xorg-xauth \
    xorg-fonts \
    xorg-fonts-75dpi \
    xorg-fonts-100dpi \
    firefox \
    sudo

RUN pip2 install \
    Paver \
    robotframework \
    robotframework-rfdoc \
    robotframework-selenium2library \
    robotframework-selenium2screenshots \
    robotframework-sshlibrary \
    robotframework-tools \
    robotframework-hub \
    Pygments

RUN git clone https://github.com/robotframework/RIDE.git


RUN useradd -m -G wheel -U admin 
RUN echo 'admin:secret' | chpasswd
RUN echo 'admin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


USER admin
ENV HOME /home/admin
WORKDIR /RIDE
CMD ["/usr/bin/paver", "run"]

