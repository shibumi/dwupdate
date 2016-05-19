# dwupdate

## What is dwupdate?

dwupdate is a simple, colourful and hackable statusbar for DWM.
It can display the following information:

* Disk usage
* CPU temperature
* Wifi state + IP + DNS IP
* Ethernet state + IP + DNS IP
* Battery state
* Sound state
* RAM usage
* CPU usage
* Systemd-nspawn container states
* Date 
* time
* active firewalld zones
* firewalld lockdown and panic status

## Dependencies

* acpi
* gawk
* sysstat
* systemd 
* pamixer
* libnotify
* firewalld

## Screenshots

![screenshot](https://paste.archlinux.de/BCL9N7/)

## Performance

The Performance is still a problem. Although I have managed to reduce the
CPU usage a lot with reusing of function feedback and the use of busctl
instead of raw command calls it can be still a lot faster and save more
ressources. This leads me to my future plans..

## Future plans

dwupdate is so big now, that I plan to rewrite it in fast and easy C. 
I want to concentrate on services that support dbus for fast and spare
queries. 
