#sudo zypper ar -cfp 90 https://packman.opensuse.net.br/openSUSE_Tumbleweed/ packman ;
sudo zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman ; 
sudo zypper ref ;
sudo zypper dup --from packman --allow-downgrade --allow-vendor-change ;
sudo zypper in --from packman ffmpeg vlc gstreamer-plugins-bad gstreamer-plugins-libav gstreamer-plugins-ugly libavcodec58 libavdevice58 libavfilter7 libavformat58 libavresample4 libavutil56 vlc-codecs ;
