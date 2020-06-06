FROM ubuntu:20.04

RUN apt update
RUN apt install -y curl git wget sudo build-essential make
# sudo warning workaround
RUN echo "Set disable_coredump false" >> /etc/sudo.conf
RUN apt install -y python3 python3-pip
RUN apt install -y pgcli ripgrep
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt install -y nodejs
RUN npm install -g yarn
RUN apt install -y vim

# install the shell
RUN curl https://raw.githubusercontent.com/kakulukia/dotfiles/master/misc/setup.sh | sh

RUN wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
RUN mv jq-linux64 ~/bin/jq
RUN chmod +x ~/bin/jq

RUN pip3 install httpie
# enable this to fully install SpaceVim
#RUN git clone https://github.com/Shougo/dein.vim "/root/.cache/vimfiles/repos/github.com/Shougo/dein.vim"
#RUN vim "+call dein#install#_update([], 'update', 0)" '+qall'

RUN apt install -y bsdmainutils
RUN wget https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
RUN chmod +x prettyping
RUN mv prettyping ~/bin

CMD sleep 1d
