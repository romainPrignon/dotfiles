#!/usr/bin/env python

# docker run -it --name test -v $PWD:/opt -w /opt python:3.7-stretch /bin/bash && docker rm test
from os import makedirs

user = "romainprignon"
dotfile_dir_absolute_path = f"/home/{user}/workspace/romainprignon/dotfiles"
home_dir_absolute_path = f"/home/{user}"

dir_to_create = ["foo"]
list(map(lambda d: makedirs(f"{home_dir_absolute_path}/{d}"), dir_to_create))
