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
    openssh \
    xorg-xauth \
    x11-ssh-askpass \
    xorg-fonts \
    xorg-fonts-75dpi \
    xorg-fonts-100dpi \
    firefox

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

RUN mkdir /var/run/sshd
RUN echo 'root:ride' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/\#X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config

RUN git clone https://github.com/robotframework/RIDE.git

RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

