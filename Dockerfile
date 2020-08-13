FROM ubuntu:20.04

ENV TERM xterm-256color
ENV WORK_USERNAME user

RUN apt-get update && apt-get install -y \
        sudo \
        tmux \
        zsh \
        httpie \
        git \
        vim \
        wget \
        curl \
        silversearcher-ag


RUN echo $WORK_USERNAME
RUN useradd -ms /bin/zsh $WORK_USERNAME
RUN echo "$WORK_USERNAME ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
USER $WORK_USERNAME
WORKDIR /home/$WORK_USERNAME

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone https://github.com/gpakosz/.tmux.git
RUN ln -s -f .tmux/.tmux.conf .
COPY .tmux.conf.local /home/${WORK_USERNAME}

RUN curl -sLf https://spacevim.org/install.sh | bash
COPY init.toml .SpaceVim.d/init.toml

ENTRYPOINT ["zsh"]
