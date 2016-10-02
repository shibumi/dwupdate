#!/usr/bin/zsh
#
# dwupdate-audit.sh - support script for dwupdate
# 
# Copyright (c) 2016 by Christian Rebischke <chris.rebischke@archlinux.org>
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
# Email : chris.rebischke@archlinux.org
# Github: www.github.com/Shibumi
#
# 
# 
#
# vim:set et sw=4 ts=4 tw=72:
#


while true
do
    if [ -d "/tmp/arch-audit" ]
    then
        arch-audit -q > /tmp/arch-audit/vulnerable
        arch-audit -qu > /tmp/arch-audit/upgradeable
    else
        mkdir /tmp/arch-audit
        arch-audit -q > /tmp/arch-audit/vulnerable
        arch-audit -qu > /tmp/arch-audit/upgradeable
    fi
    sleep 30m
done
