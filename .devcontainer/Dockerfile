# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.241.1/containers/debian/.devcontainer/base.Dockerfile

# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): bullseye, buster
ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# ** [Optional] Uncomment this section to install additional packages. **
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends  \
    curl       \
    wget       \
    nmap       \
    zsh

COPY .zshrc /home/vscode/.zshrc
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-/home/vscode/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-/home/vscode/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


RUN /usr/bin/zsh /home/vscode/.zshrc

#Install Anisble
LABEL maintainer="Jeff Geerling"
ARG DEBIAN_FRONTEND=noninteractive
ENV pip_packages "ansible cryptography" 

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    sudo systemd systemd-sysv \
    build-essential wget libffi-dev libssl-dev procps \
    python3-pip python3-dev python3-setuptools python3-wheel python3-apt \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# Upgrade pip to latest version.
RUN pip3 install --upgrade pip

# Install Ansible via pip.
RUN pip3 install $pip_packages

RUN pip3 install mitogen

COPY initctl_faker .
RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# Make sure systemd doesn't start agettys on tty[1-6].
RUN rm -f /lib/systemd/system/multi-user.target.wants/getty.target

# Install Ansible collections
RUN mkdir -p /tmp/collection && chown vscode:vscode /tmp/collection -R
COPY requirements.yml /tmp/collection/

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]
