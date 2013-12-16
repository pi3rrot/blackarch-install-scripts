#!/bin/bash
################################################################################
#                                                                              #
# blackarchinstall - Blackarch Install                                         #
#                                                                              #
# FILE                                                                         #
# blackarchinstall.sh                                                          #
#                                                                              #
# DATE                                                                         #
# 2013-12-16                                                                   #
#                                                                              #
# DESCRIPTION                                                                  #
# Script for easy install                                                      #
#                                                                              #
# AUTHOR                                                                       #
# nrz@nullsecurity.net                                                         #
#                                                                              #
################################################################################

# SECURITY VAR - this version can rm -rf /* your hard drive
SEC_ENABLE="true"

# HD beta var
HD="sda"

# blackarchinstall version
VERSION="blackarchinstall v0.1"

# true / false
FALSE="0"
TRUE="1"

# return codes
SUCCESS="1337"
FAILURE="31337"

# verbose mode - default: quiet
VERBOSE="/dev/null"

# colors
WHITE="$(tput bold ; tput setaf 7)"
GREEN="$(tput setaf 2)"
RED="$(tput bold; tput setaf 1)"
YELLOW="$(tput bold ; tput setaf 3)"
NC="$(tput sgr0)" # No Color

# root variable
ROOT="/tmp/blackarch"


gprintf() {
    fmt=$1
    shift
    printf "%s${fmt}%s\n" "${WHITE}" "$@" "${NC}"

    return "${SUCCESS}"
}

# print warning
warn()
{
    printf "%s[!] WARNING: %s%s\n" "${RED}" "${*}" "${NC}"

    return "${SUCCESS}"
}

# print error and exit
err()
{
    printf "%s[-] ERROR: %s%s\n" "${RED}" "${*}" "${NC}"

    return "${SUCCESS}"
}

# print error and exit
cri()
{
    printf "%s[-] CRITICAL: %s%s\n" "${RED}" "${*}" "${NC}"
    
    exit "${FAILURE}"
}


# usage and help
usage()
{
cat <<EOF
Usage: $0 <arg> | <misc>
OPTIONS:
    -i: install
MISC:
    -V: print version and exit
    -H: print help and exit
EOF
    return "${SUCCESS}"
}

# leet banner, very important
banner()
{
    printf "%s--==[ BlackArch Install ]==--%s\n" "${YELLOW}" "${NC}"

    return "${SUCCESS}"
}

# check argument count
check_argc()
{
    return "${SUCCESS}"
}

# check if required arguments were selected
check_args()
{
    return "${SUCCESS}"
}


update_system()
{
    printf '[blackarch]\nserver = http://www.blackarch.org/pub/blackarch/$arch\n' >> /etc/pacman.conf
    pacman -Syu --noconfirm
    
    return "${SUCCESS}"
}

format_filesystem()
{
    # TODO: add swap 

    parted -s "/dev/${HD}" mklabel msdos

    # boot partition
    parted -a optimal "/dev/${HD}" mkpart primary 0% 100MB
    # partition bootable
    parted "/dev/${HD}" set 1 boot on
    # root partition
    parted -a optimal "/dev/${HD}" mkpart primary 100MB 100%

    # formating
    mkfs.ext2 -L boot /dev/sda1
    mkfs.ext4 -L root /dev/sda2

    _printf "[+] Created boot partition: /dev/sda1 - ext2"
    _printf "[+] Created root partition: /dev/sda2 - ext4"

    
    return "${SUCCESS}"
}

mount_filesystem()
{
    #TODO: change boot device for user required
    
    mkdir "${ROOT}"
    mkdir "${ROOT}/boot"
    
    mount -t ext4 "/dev/${HD}2" "${ROOT}" 
    mount -t ext2 "/dev/${HD}1" "${ROOT}/boot"
      
    return "${SUCCESS}"
}

install_packages()
{
    pacstrap -c "${ROOT}" base blackarch

    return "${SUCCESS}"
}

install_grub()
{
    grub-install --boot-directory="/mnt/${ROOT}/boot" /dev/${HD}

    return "${SUCCESS}"
}

install()
{
    gprintf "[+] Updating system..."
    update_system
    
    gprintf "[+] Partitioning ${HD}..."
    format_filesystem

    gprintf "[+] Mounting filesystem..."
    mount_filesystem

    gprintf "[+] Installing BlackArch packages..."
    install_packages

    gprintf "[+] Installing grub..."
    install_grub

    return "${SUCCESS}"
}

# parse command line options
get_opts()
{
    while getopts ivVH flags
    do
        case "${flags}" in
            i)
                #optarg=${OPTARG}
                opt="install"
                ;;
            v)
                VERBOSE="/dev/stdout"
                ;;
            V)
                printf "%s\n" "${VERSION}"
                exit "${SUCCESS}"
                ;;
            H)
                usage
                ;;
            *)
                err "WTF?! mount /dev/brain"
                ;;
        esac
    done

    return "${SUCCESS}"
}


# controller and program flow
main()
{
    banner
    check_argc ${*}
    get_opts ${*}
    check_args ${*}

    if [ "${opt}" == "install" ]; then
        if [[ "${SEC_ENABLE}" == "false" ]]; then
            install
        else
            cri "SEC_ENABLE var active"
        fi
    fi
    return "${SUCCESS}"
}


# program start
main ${*}

# EOF
