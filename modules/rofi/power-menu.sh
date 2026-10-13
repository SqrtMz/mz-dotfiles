#! /usr/bin/env bash

option=$(echo -e "󰐥 Power off\n󰜉 Reboot\n󰒲 Hibernate" | rofi -dmenu -p "Power menu" -theme black-glass-power-menu.rasi)

case $option in
	"󰐥 Power off"	) systemctl poweroff;;
	"󰜉 Reboot"	) systemctl reboot;;
	"󰒲 Hibernate"	) systemctl hybrid-sleep;;
esac