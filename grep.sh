#!/bin/sh


distro=eoan

for i in $(cat packages); do


pkg=$(curl  "https://packages.ubuntu.com/$distro/amd64/$i/download"  |   grep  de.archive.ubuntu.com | grep -Eo 'href="[^\"]+"' | grep -Eo '(http|https)://[^"]+')
pkg2=$(curl  "https://packages.ubuntu.com/$distro//amd64/$i/download" |   grep http://security.ubuntu.com | grep -Eo 'href="[^\"]+"' | grep -Eo '(http|https)://[^"]+')

echo $pkg >> 1
echo $pkg2 >> 1

  done