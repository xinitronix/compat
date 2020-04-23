#!/bin/sh

MASTER_SITES=

UBUNTU_VERSION=18.10




if ! [ -d  "ubuntu"  ]; then

           mkdir -p  ubuntu

       fi


if ! [ -d  "deb"  ]; then

           mkdir -p  deb

       fi

if ! [ -d  "tar"  ]; then

           mkdir -p  tar

       fi


                for BIN_DISTFILES in $(cat listpackages_$UBUNTU_VERSION);do

                        if ! [ -f deb/$(echo  $BIN_DISTFILES | rev | sed -r 's/\/.+//' | rev) ]; then
         
                       cd  deb &&   fetch $MASTER_SITES$BIN_DISTFILES
                       cd ../
 
                        fi 
                 done

                for DEB   in $(cat listpackages_$UBUNTU_VERSION); do
                   
                    deb2targz deb/$(echo  $DEB | rev | sed -r 's/\/.+//' | rev)

                 done


             for TARGZ in $(ls deb | grep tar.xz);do 
              
              #for TARGZ in $(cat listpackages_$UBUNTU_VERSION);do  

                    tar xf deb/$TARGZ  -C  ubuntu 
                  # tar xf deb/$(echo  $TARGZ  | rev | sed -r 's/\/.+//' | rev | sed s/.deb/.tar.*/) -C  ubuntu 

                 done


rm  -R         ubuntu/boot ubuntu/dev ubuntu/etc/fonts ubuntu/home   ubuntu/root ubuntu/tmp \
               ubuntu/var/log  ubuntu/var/tmp 

ln -s    bash                              ubuntu/bin/sh
rm                                         ubuntu/lib64/ld-linux-x86-64.so.2
ln -s ../lib/x86_64-linux-gnu/ld-2.19.so   ubuntu/lib64/ld-linux-x86-64.so.2



                 cp /compat/linux/usr/lib/$(ls /compat/linux/usr/lib/ | grep libGL.so | head -3 | tail -n 1) ubuntu/usr/lib
                 cp /compat/linux/usr/lib/$(ls /compat/linux/usr/lib/ | grep libnvidia-glcore) ubuntu/usr/lib
                 cp /compat/linux/usr/lib/$(ls /compat/linux/usr/lib/ | grep libnvidia-tls) ubuntu/usr/lib
                 cp /compat/linux/usr/lib/$(ls /compat/linux/usr/lib/ | grep libGLX) ubuntu/usr/lib
                 cp /compat/linux/usr/lib/$(ls /compat/linux/usr/lib/ | grep libGLdispatch.so.0.0.0) ubuntu/usr/lib
                 cp /compat/linux/usr/lib/$(ls /compat/linux/usr/lib/ | grep libGLX.so.0.0.0  ) ubuntu/usr/lib
                 ln -s  $(ls /compat/linux/usr/lib/ | grep libGLX.so.0.0.0  )                           ubuntu/usr/lib/libGLX.so.0
                 ln -s  $(ls /compat/linux/usr/lib/ | grep libGLdispatch.so.0.0.0)                      ubuntu/usr/lib/libGLdispatch.so.0
                 ln -s  $(ls /compat/linux/usr/lib/ | grep libGL.so | head -3 | tail -n 1)              ubuntu/usr/lib/libGL.so.1             




doas cp -R  ubuntu /compat
doas mkdir  /compat/ubuntu/tmp
doas mkdir  /compat/ubuntu/proc
doas mkdir  /compat/ubuntu/sys
doas mkdir -p   /compat/ubuntu/dev/shm



