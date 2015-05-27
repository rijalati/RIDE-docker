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

RUN mkdir /var/run/sshd

RUN sed -i 's/\#X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config

RUN git clone https://github.com/robotframework/RIDE.git
RUN  /etc/init.d/sshd start

RUN useradd admin -G wheel
RUN echo 'admin:secret' | chpasswd
RUN echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

RUN mkdir -p /home/admin/.ssh
ADD authorized_keys /home/admin/.ssh/
RUN chown -R admin:admin /home/admin/.ssh; chmod 700 /home/admin/.ssh

#RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
#RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
#RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
#RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

