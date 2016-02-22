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
# Email : Chris.Rebischke@archlinux.org
# Github: www.github.com/Shibumi
#
#
# Usage:
# `dwupdate &`
#
# vim:set noet sts=4 sw=4 ts=4 tw=76:


ether="enp0s25"
wifi="wlp3s0"


# Main-Functions
disk_main=$(df -h | grep "root")
acpi_b_main=$(acpi -b)
wifi_main=$(networkctl status $wifi)
ether_main=$(networkctl status $ether)
disk_perc=$(echo $disk_main | awk '{ printf "%0.f", $5 }')
disk_size=$(echo $disk_main | awk '{ print $2 }')
disk_use=$(echo $disk_main  | awk '{ print $3 }')
temp=$(acpi -t | awk '{printf "%d", $4}')
wifi_state=$(echo "$wifi_main" | awk '/State/{ print $2 }')
wifi_address=$(echo "$wifi_main" | awk '/^\s+Address/{ print $2 }')
wifi_dns=$(echo "$wifi_main" | awk '/DNS/{ print $2 }')
ether_state=$(echo "$ether_main" | awk '/State/{ print $2 }')
ether_address=$(echo "$ether_main" | awk '/^\s+Address/{ print $2 }')
ether_dns=$(echo "$ether_main" | awk '/DNS/{ print $2 }')
bat_state=$(echo $acpi_b_main | awk '{print $3}')
bat_perc=$(echo $acpi_b_main | awk '{printf "%d", $4}')
bat_remaining=$(echo $acpi_b_main | awk '{print $5}')
sound_state=$(pamixer --get-mute)
sound_perc=$(pamixer --get-volume)
ram_usage=$(free -h | awk '/Mem/{print $3 }')
ram_capacity=$(free -h | awk '/Mem/{ print $2 }')
ram_perc=$(free | awk '/Mem/{print $3/$2 * 100.0}' | cut -d"." -f1)
cpu_usage=$(mpstat 1 1 | awk '/Average/{ printf "%.0f", 100-$NF }')
date=$(date -I)
datetime=$(date '+%I:%M %p')
output=""

# Disk usage

if [[ $disk_perc -ge 90 ]]
then
    output+="D: $disk_use / $disk_size"
elif [[ $disk_perc -ge 70 ]]
then
    output+="D: $disk_use / $disk_size"
else
    output+="D: $disk_use / $disk_size"
fi


# Temperature

if [[ $temp -ge 86 ]]
then
    output+="T: ${temp}C"
elif [[ $temp -gt 65 ]]
then
    output+="T: ${temp}C"
else
    output+="T: ${temp}C"
fi

# Wifi

if [[ $wifi_state == "routable" ]]
then
    output+="W: (IP:$wifi_address : DNS:$wifi_dns)"

else
    output+="W: Down"
fi

# Ethernet

if [[ $ether_state == "routable" ]]
then
    output+="E: (IP:$ether_address : DNS:$ether_dns)"
else
    output+="E: Down"
fi

# Battery

if [[ $bat_state == "Discharging," ]]
then
    if [[ $bat_perc -ge 20 ]] 
    then
        output+="B: (v $bat_perc% : $bat_remaining)"
    elif [[ $bat_perc -ge 10 ]]
    then
        output+="B: (v $bat_perc% : $bat_remaining)"
    else
        output+="B: (v $bat_perc% : $bat_remaining)"
    fi
else
    output+="B: ^ $bat_perc%"
fi

# Sound

if [[ $sound_state == "false" ]]
then
    output+="S: $sound_perc"
else
    output+="S: $sound_perc"
fi

# RAM

if [[ $ram_perc -ge 90 ]]
then
    output+="RAM: $ram_usage / $ram_capacity"
elif [[ $ram_perc -ge 50 ]]
then
    output+="RAM: $ram_usage / $ram_capacity"
else
    output+="RAM: $ram_usage / $ram_capacity"
fi

# CPU

if [[ $cpu_usage -ge 90 ]]
then
    output+="CPU: $cpu_usage%"
elif [[ $cpu_usage -ge 50 ]]
then
    output+="CPU: $cpu_usage%"
else
    output+="CPU: $cpu_usage%"
fi

# Date/Time

output+="$date $datetime"
xsetroot -name "$output"
