#! /usr/bin/env bash

function fatal_error() {
    if [ -d "/boot" ]
    then
        echo -e "There was an error while $2. Killing the script... \n"
        exit $1
    fi
}

while true
do
    echo -e "Path to EFI partition: \c"
    read efi

    if [ ! -e $efi ]
	then
            echo -e "Invalid partition, try again \n"
            continue
    fi

    echo -e "Format partition? [y/n]"
    read efif

    case $efif in
        [Yy] ) echo
                echo -e "The partition will be formatted and mounted \n"
                format=1;;

        [Nn] ) echo
                echo -e "The partition will only be mounted \n";;

        * ) echo
			#pacman &> /dev/null;;
			fatal_error $? "sleeping peacefully"
			continue;;
    esac

    if [[ $format == 1 ]]
    then
        echo -e "FORMATTING... \n"
    fi

    echo -e "MOUNTING... \n"
    
    break
done
