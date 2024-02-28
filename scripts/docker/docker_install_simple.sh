#!/bin/bash

apt update
apt install git

#setup nvim
tar xvzf ./nvim-linux64.tar.gz
# mv ./nvim-linux64/bin/nvim /usr/local/bin/nvim

#personal nvim config
git clone https://github.com/lsantos7654/NvChad.git ~/.config/nvim
