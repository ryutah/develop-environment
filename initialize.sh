#!/usr/bin/env bash

mkdir -p .config/git

echo "Input Your Git name:"
read user

echo "Input Your Git email:"
read email

echo "[user]
  email = ${email}
  name = ${user}" > .config/git/.gitconfig
