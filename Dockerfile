ARG version=trixie
FROM debian:$version

ENV DEBIAN_FRONTEND noninteractive

ARG user=romainprignon
ARG password=romainprignon

# Install basic dependencies needed for testing
RUN apt update && apt install -y \
    bash \
    curl \
    git \
    make \
    openssl \
    sudo \
    wget

RUN useradd --create-home --password $(echo "$password" | openssl passwd -1 -stdin) --shell /bin/bash $user
RUN usermod -aG sudo $user
RUN echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $user

RUN mkdir -p /home/$user/workspace/$user/dotfiles
WORKDIR /home/$user/workspace/$user/dotfiles

COPY --chown=$user:$user . .

CMD ["bash"]