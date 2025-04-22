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
    echo 'testuser1 ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Benutzer testuser2 ohne sudo
RUN useradd -m -s /bin/bash testuser2

# Automatischer Start von setup.sh beim Login (nur testuser1)
RUN echo '\
    if [[ $- == *i* ]] && [ -f "$HOME/ghar/dotfiles/misc/setup.sh" ]; then \n\
    echo ">> Starte Setup: ghar/dotfiles/misc/setup.sh" \n\
    bash "$HOME/ghar/dotfiles/misc/setup.sh" \n\
    fi' >> /home/testuser1/.bashrc

# Start direkt in Bash
CMD ["/bin/bash"]
