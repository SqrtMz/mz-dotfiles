#! /usr/bin/env bash

option=$(echo -e "󰐥 Power off\n󰜉 Reboot\n󰒲 Suspend\n Hibernate" | rofi -dmenu -p "Power menu" -theme black-glass-power-menu.rasi)

case $option in
	"󰐥 Power off"	) systemctl poweroff;;
	"󰜉 Reboot"		) systemctl reboot;;
	"󰒲 Suspend"		) systemctl suspend;;
	" Hibernate"	) systemctl hibernate;;
esac