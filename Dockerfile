ARG version
FROM ubuntu:$version

ENV DEBIAN_FRONTEND noninteractive

ARG user=romainprignon
ARG password=romainprignon

RUN apt update && apt install -y \
    make \
    openssl \
    sudo

RUN useradd --create-home --password $(echo "$password" | openssl passwd -1 -stdin) --shell /bin/bash $user
RUN usermod -aG sudo $user

USER $user

RUN mkdir -p /home/$user/workspace/$user/dotfiles
WORKDIR /home/$user/workspace/$user/dotfiles

COPY --chown=$user:$user . .

CMD ["bash"]