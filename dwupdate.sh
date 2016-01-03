#!/bin/bash
#
# dwupdate.sh - statusbar updater with colours via statuscolor
# 
# Copyright (c) 2015 by Christian Rebischke 
# <echo Q2hyaXMuUmViaXNjaGtlQGdtYWlsLmNvbQo= | base64 -d>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http: #www.gnu.org/licenses/
#
#====================================================================== 
# Author: Christian Rebischke
# Email : echo Q2hyaXMuUmViaXNjaGtlQGdtYWlsLmNvbQo= | base64 -d
# Github: www.github.com/Shibumi
#
# 
# Usage:
# bash dwupdate.sh | while read -r; do xsetroot -name "$REPLY"; done &
#
# vim:set noet sts=4 sw=4 ts=4 tw=76:

# Main-Functions
wifi_state=$(ip addr | grep 'wlp2s0' | head -1 | awk '{ print $9 }')
wifi_name=$(netctl list | grep "*" | awk '{ print $2 }')
wifi_bitrate=$(iwconfig wlp2s0| grep -o "[0-9]* Mb/s")
ether_state=$(ip addr | grep 'enp8s0' | head -1 | awk '{ print $9 }')
bat_state=$(cat /sys/class/power_supply/BAT1/status)
bat_perc=$(cat /sys/class/power_supply/BAT1/capacity)
sound_state=$(amixer get Master -M | grep -o "\(\[on\]\)\|\(\[off\]\)")
sound_perc=$(amixer get Master -M | grep -oE "[[:digit:]]*%")
ram_usage=$(free -h | grep Mem | awk '{print $3 }') 
ram_capacity=$(free -h | grep Mem | awk '{ print $2 }')
ram_perc=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d"." -f1)
cpu_usage=$(mpstat 1 1 | grep 'Average' | awk '{ printf "%.0f", 100-$NF }')
date=$(date -u -I)
datetime=$(date -u '+%I:%M %p')
output=""

# Wifi

if [[ $wifi_state == "UP" ]]
then
	output+="W: ($wifi_name:$wifi_bitrate)"

else 
	output+="W: Down"
fi

# Ethernet

if [[ $ether_state == "UP" ]]
then
	output+="E: Up"
else
	output+="E: Down"
fi

# Battery

if [[ $bat_state == "Discharging" ]]
then
    if [[ $bat_perc -gt 50 ]] && [[ $bat_perc -lt 100 ]]
    then
        output+="B: v $bat_perc"
    elif [[ $bat_perc -gt 20 ]] && [[ $bat_perc -lt 50 ]]
    then
        output+="B: v $bat_perc"
    else
        output+="B: v $bat_perc"
    fi
else
	output+="B: ^ $bat_perc"
fi

# Sound

if [[ $sound_state == "[on]" ]]
then
	output+="S: $sound_perc"
else
	output+="S: $sound_perc"
fi

# RAM

if [[ $ram_perc -ge 90 ]]
then
	output+="RAM: $ram_usage / $ram_capacity"
elif [[ $ram_perc -lt 90 ]] && [[ $ram_perc -ge 50 ]]
then
	output+="RAM: $ram_usage / $ram_capacity"
else
	output+="RAM: $ram_usage / $ram_capacity"
fi

# CPU

if [[ $cpu_usage -ge 90 ]]
then
	output+="CPU: $cpu_usage%"
elif [[ $cpu_usage -lt 90 ]] && [[ $cpu_usage -ge 50 ]]
then
	output+="CPU: $cpu_usage%"
else
	output+="CPU: $cpu_usage%"
fi

# Date/Time

output+="$date $datetime"
echo -e $output
