#!/bin/sh

distro=eoan


    pak=$(curl  "https://packages.ubuntu.com/$distro/amd64/$1/download"  |   grep  de.archive.ubuntu.com | grep -Eo 'href="[^\"]+"' | grep -Eo '(http|https)://[^"]+')
    pak2=$(curl "https://packages.ubuntu.com/$distro/amd64/$1/download" |   grep http://security.ubuntu.com | grep -Eo 'href="[^\"]+"' | grep -Eo '(http|https)://[^"]+')


   if ! [ -d  "ubuntu"  ]; then

           mkdir -p  ubuntu

       fi


    if ! [ -d  "deb"  ]; then

           mkdir -p  deb

       fi

   if ! [ -d  "tar"  ]; then

           mkdir -p  tar

       fi


     cd  deb &&   fetch $pak 
                  fetch  $pak2
    doas dpkg --extract $(echo $pak   | rev | sed -r 's/\/.+//' | rev) /compat/ubuntu
    doas dpkg --extract $(echo $pak2   | rev | sed -r 's/\/.+//' | rev) /compat/ubuntu
         cd ../

     
 