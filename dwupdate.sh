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
# 
#
# vim:set noet sts=4 sw=4 ts=4 tw=76:
#


wifi_state=$(ip addr | grep 'wlp2s0' | head -1 | awk '{ print $9 }')
ether_state=$(ip addr | grep 'enp8s0' | head -1 | awk '{ print $9 }')
bat_state=$(cat /sys/class/power_supply/BAT1/status)
bat_perc=$(cat /sys/class/power_supply/BAT1/capacity)
wifi_name=$(netctl list | grep "*" | awk '{ print $2 }')
ram_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
ram_capacity=$(free -h | grep Mem | awk '{ print $2 }')
cpu_usage=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END
{print usage}')
date=$(date -u -I)
datetime=$(date -u '+%I:%M')




