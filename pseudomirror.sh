#!/bin/sh


# Sync with the website hosted on Gitlab


git_user="xgqt"
git_repo="xgqt.gitlab.io"
git_remote="https://gitlab.com/${git_user}/${git_repo}.git"

clone_dir="/tmp/${git_repo}"
here_dir="$(pwd)"


clean_clone_dir() {
    [ -d "${clone_dir}" ] && rm -rfd "${clone_dir}"
}


clean_clone_dir
git clone --verbose --recursive "${git_remote}" "${clone_dir}"
cp -r "${clone_dir}"/public/* "${here_dir}"
clean_clone_dir
git add .
git commit -m "update with pseudomirror script"
git push
