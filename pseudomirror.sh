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


cat << INFO
git_user:   ${git_user}
git_repo:   ${git_repo}
git_remote: ${git_remote}
clone_dir:  ${clone_dir}
here_dir:   ${here_dir}
INFO

clean_clone_dir

git clone --verbose --recursive "${git_remote}" "${clone_dir}"

cd "${clone_dir}"/public || exit 1

for f in *
do
    rm -dr "${here_dir:-.}"/"${f}"
    cp -r "${f}" "${here_dir}"
done

cd "${here_dir}" || exit 1
clean_clone_dir

git add .
git commit -m "update with pseudomirror script"
git push
