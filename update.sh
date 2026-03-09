#!/bin/bash

URL="https://discord.com/api/download?platform=linux"
curl -L -o /tmp/discord.deb $URL
deb_version=$(dpkg -f /tmp/discord.deb Version)
build_info=$(dpkg -L Discord | grep "build_info")
curr_version=$(jq -r '.version' "$build_info")

# Determine the distro
# Here are some known OSes:
# - On Mac: Darwin
# - On FreeBSD or GhostBSD: FreeBSD
# - On Fedora: fedora
# - On Ubuntu: ubuntu
# - On Raspbian: raspbian
function get_distro() {
    if [[ -f /etc/os-release ]]
    then
        # On Linux systems
        source /etc/os-release
        echo $ID
    else
        # On systems other than Linux (e.g. Mac or FreeBSD)
        uname
    fi
}

case $(get_distro) in
    case raspbian)
        echo This is Raspbian
        ;;
    case fedora)
        echo This is Fedora
        ;;
    case ubuntu)
        echo This is Ubuntu
        ;;
    case Darwin)
        echo This is macOS
        ;;
esac

if [[ "${curr_version##*.}" -lt "${deb_version##*.}" ]]; then
	sudo apt install /tmp/discord.deb
elif [[ "${deb_version##*.}" == "${curr_version##*.}" ]]; then
	echo "Discord is up-to-date with version $curr_version"
elif [[ "${curr_version##*.}" -gt "${deb_version##*.}" ]]; then
	# This should never happen
	echo "Error with version num in $build_info :("
fi


