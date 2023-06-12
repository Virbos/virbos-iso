# fix for screen readers
if grep -Fqa 'accessibility=' /proc/cmdline &> /dev/null; then
    setopt SINGLE_LINE_ZLE
fi

~/.automated_script.sh

alias virbos-setup="curl https://raw.githubusercontent.com/Virbos/virbos-livescripts/master/virbos-setup | bash"
