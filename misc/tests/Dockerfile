# Dockerfile
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Grundlegende Tools installieren
RUN apt-get update && apt-get install -y \
    sudo \
    bash \
    curl \
    git \
    vim \
    locales \
    && locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Benutzer testuser1 mit sudo ohne Passwort
RUN useradd -m -s /bin/bash testuser1 && \
    echo 'testuser1:test' | chpasswd && \
    echo 'testuser1 ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Benutzer testuser2 ohne sudo
RUN useradd -m -s /bin/bash testuser2 && \
    echo 'testuser2:test' | chpasswd

# Automatischer Start von setup.sh beim Login (für testuser1 und testuser2)
RUN printf '%s\n' \
'echo ">> Starte Setup: ghar/dotfiles/misc/setup.sh"' \
'bash "$HOME/ghar/dotfiles/misc/setup.sh"' \
>> /home/testuser1/.bashrc && \
printf '%s\n' \
'echo ">> Starte Setup: ghar/dotfiles/misc/setup.sh"' \
'bash "$HOME/ghar/dotfiles/misc/setup.sh"' \
>> /home/testuser2/.bashrc

# Start direkt in Bash
CMD ["/bin/bash"]
