#!/usr/bin/env bash
set -eo pipefail

app_name="vim-config"
repo_uri="https://github.com/sanjayz09/vimrc.git"
repo_name="vim-config"
repo_path="$HOME/.vim/vim-config"
repo_branch="master"
repo_vundle_name="vundle"
repo_vundle_uri="https://github.com/VundleVim/Vundle.vim.git"
repo_vundle_path="$HOME/.vim/bundle/Vundle.vim"
bundle_path="$HOME/.vim/bundle"
_with_plugin=
_update=
_uninstall=

help() {
cat << EOF
    usage: $0 [OPTIONS]
        --help          Show this message
        --with-plugin   Config Vim with plguin
        --update        Update
        --uninstall     Uninstall
EOF
}

for opt in "$@"; do
    case $opt in
        --help)
            help
            exit 0
            ;;
        --with-plugin)  _with_plugin=1
            ;;
        --update)       _update=1
            ;;
        --uninstall)    _uninstall=1
            ;;
        *)
            echo "unknown option: $opt"
            help
            exit 1
            ;;
    esac
done

###############################
## Basic tools
###############################
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\\33[32m[✔]\\33[0m ${1}${2}"
    fi
}

error() {
    msg "\\33[31m[✘]\\33[0m ${1}${2}"
    exit 1
}

exists() {
    command -v "$1" >/dev/null 2>&1
}

confirm() {
    while true; do
        read -p "$1" -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy] ]]; then
            return 0
        elif [[ "$REPLY" =~ ^[Nn] ]]; then
            return 1
        fi
    done
}

sync_repo() {
    if [ ! -e "$repo_path" ]; then
        msg "\\033[1;34m==>\\033[0m Trying to clone $repo_name"
        mkdir -p "$repo_path"
        git clone -b "$repo_branch" "$repo_uri" "$repo_path" --depth=1
        ret="$?"
        success "Successfully cloned $repo_name."
    else
        msg "\\033[1;34m==>\\033[0m Trying to update $repo_name"
        cd "$repo_path" && git pull origin "$repo_branch"
        ret="$?"
        success "Successfully updated $repo_name"
    fi
}

sync_repo_vundle() {
    if [ ! -e "$repo_vundle_path" ]; then
        msg "\\033[1;34m==>\\033[0m Trying to clone $repo_vundle_name"
        mkdir -p "$repo_vundle_path"
        git clone "$repo_vundle_uri" "$repo_vundle_path"
        ret="$?"
        success "Successfully cloned $repo_vundle_name"
    else
        msg "\\033[1;34m==>\\033[0m Trying to update $repo_vundle_name"
        cd "$repo_vundle_path" && git pull
        ret="$?"
        success "Successfully updated $repo_vundle_name"
    fi
}

backup() {
    if [ -e "$1" ]; then
        echo
        msg "\\033[1;34m==>\\033[0m Attempting to back up your original vim configuration"
        today=$(date +%Y%m%d_%s)
        mv -v "$1" "$1.$today"

        ret="$?"
        success "Your original vim configuration has been backed up"
    fi
}

check_git() {
    if ! exists "git"; then
        error "You must have 'git' installed to continue"
    fi
}

install_plugins() {
    for exe in "$@"; do
        eval "$exe +PluginInstall +qall"
    done
    ret="$?"
    success "Successfully installed plugins via vim-plug"
}

install_for_vim() {
    backup "$HOME/.vimrc"
    ret="$?"

    ln -sf "$repo_path/.vimrc" "$HOME/.vimrc"
}

install_for_vim_with_plugin() {
    install_for_vim
    install_plugins "vim"
}

install() {
    if [ ! -z "$_with_plugin" ]; then
        sync_repo_vundle
        install_for_vim_with_plugin
        return
    fi
    install_for_vim
}

uninstall() {
    rm -f "$HOME/.vimrc"
    rm -rf $repo_path
    rm -rf $repo_vundle_path
    rm -rf $bundle_path
}

###############################
##  main
###############################
if [ ! -z "$_uninstall" ]; then
    if confirm "    - Uninstall (y/n) ? "; then
        uninstall
        echo  "      - Uninstalled"
    else
        echo  "      - Skipped"
    fi
    exit 0;
fi

check_git

sync_repo
if [ ! -z "$_update" ]; then
    exit 0;
fi

install

msg "\\nThanks for installing \\033[1;31m$app_name\\033[0m. Enjoy!"
