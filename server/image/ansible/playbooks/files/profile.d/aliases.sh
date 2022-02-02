#
# this file is provisioned by Packer
#
alias cls='/usr/bin/clear'
alias la='/usr/bin/ls -la'
alias ll='/usr/bin/ls -l'
alias p='/usr/bin/ps -fu'

if [[ -x /usr/bin/bat ]]
then
    alias bd='/usr/bin/bat --language Diff'
    alias bj='/usr/bin/bat --language JSON'
    alias bs='/usr/bin/bat --language sh'
    alias by='/usr/bin/bat --language YAML'
fi

if [[ -x /usr/bin/docker ]]
then
    alias logs='/usr/bin/docker logs --follow'
fi

if [[ -x /usr/bin/sudo ]]
then
    alias be='/usr/bin/sudo -iu'
fi

if [[ "Linux" = 'Linux' ]]
then
    alias dfh='/usr/bin/df -h -x devtmpfs -x squashfs -x tmpfs'
fi
