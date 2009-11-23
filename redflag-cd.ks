lang zh_CN.UTF-8
keyboard us
timezone Asia/Shanghai
auth --useshadow --enablemd5
#selinux --permissive
selinux --disabled
firewall --disabled
xconfig --startxonboot
part / --size 4096
services --enabled=NetworkManager --disabled=network,sshd,sendmail

#repo --name="DT7 Update" --mirrorlist=http://172.16.82.249/yum/mirrorlist.php?repo=redflag-update-7.0&arch=i386
#repo --name="DT7 Base" --mirrorlist=http://172.16.82.249/yum/mirrorlist.php?repo=redflag-base-7.0&arch=i386
#repo --name="DT7 Development" --baseurl=http://172.16.82.249/yum/rpmdevelopment
repo --name="DT7 Update" --baseurl=http://172.16.82.249/yum/rpmupdate
repo --name="DT7 Base" --baseurl=http://172.16.82.249/yum/rpmbase

%packages
@base-x
@base
@core
@fonts
#@legacy-fonts
@admin-tools
@dial-up
@hardware-support
#@printing
@games
@graphical-internet
@graphics
@sound-and-video
#@gnome-desktop
@kde-desktop

nss-mdns
NetworkManager-gnome
NetworkManager-vpnc
NetworkManager-openvpn
kernel
kernel-devel
memtest86+

# added for dependency
MAKEDEV
python
chkconfig
pam
desktop-file-utils
redflag-release
redflag-synaptics
perl
cyrus-sasl
info
diffutils
sysvinit-tools
termcap
grep
gawk
sed
psmisc
findutils
-fastboot
redflag-menus
-redhat-menus
gnome-menus
kcm_resetsys
kcm_audiosetting
kgrubeditor
rar
gnome-bluetooth
xsane
kpackagekit
aliedit
plymouth-plugin-rotation
-gnome-packagekit
fsautomount
dazhihui
flash-plugin
fusion-icon
fusion-icon-qt
fusion-icon-gtk
-rhythmbox
kdebase-workspace-wallpapers
kdesolocmd
-kprinter
-qgtkstyle
gtk-qt-engine
java-1.5.0-gcj
gtk-qt-engine
xinetd
rsh-server
isomd5sum
vnc-server
reiserfs-utils
rfpasswd
rftest
linuxqq
kdeartwork-screensavers

# livcd install
rfinstaller
grub-install-guide
yum-updatesd
wget
vim-enhanced
-wqy-bitmap-fonts
-wqy-unibit-fonts
-wqy-zenhei-fonts
rfwelcome
lzma
zhfonts
dejavu-sans-fonts
dejavu-sans-mono-fonts
dejavu-serif-fonts
dejavu-fonts-common
fontpackages-filesystem
qtparted
compiz
compiz-kde
emerald-themes
kdeadmin
-displaysetting
rfdisplayconfig
rfthemes
oxygen-cursor-themes
redflag-lsb
-alsa-kmod
-kaffeine

#firmware
iwl4965-firmware
iwl5000-firmware
iwl3945-firmware
alsa-firmware
ipw2100-firmware
ipw2200-firmware
ql2100-firmware
ql2200-firmware
ql23xx-firmware
ql2400-firmware
ql2500-firmware
iscan-firmware
b43-firmware
zerohwconf-qt4

# multimedia
mplayer
-mplayer-gui
smplayer
mplayer-codecs
mplayer-codecs-extra
x264-gtk
x264
libavc1394
faad2
libdvdnav
yasm
twolame
kmess
-msc
ccsm
guvcview
xine-lib-extras-freeworld
gnome-media
bluez-gnome

stardict
stardict-dic-zh_CN
stardict-dic-zh_TW
stardict-dic-en

amarok
RealPlayer
rfsysv
samba
samba-client
xorg-x11-drv-radeonhd
k3b
kdeplasma-addons
kdeutils
flite

#office
openoffice.org3-draw
openoffice.org3-impress
openoffice.org3-writer
openoffice.org3-math
openoffice.org3-zh-CN
openoffice.org3-calc
openoffice.org3-base
openoffice.org3.0-freedesktop-menus

# only fir debug
gdb
strace
make
gcc
gcc-c++
rpm-build
-qt-devel
-kdelibs-devel
-cmake
-subversion
-parted-devel
-emacs

# some extras

fuse
-pavucontrol

# FIXME/TODO: recheck the removals here
# try to remove some packages from livecd-redflag-base-desktop.ks
-gdm
-authconfig-gtk
-system-config-keyboard

# unwanted packages from @kde-desktop
# don't include these for now to fit on a cd
# digikam (~11 megs), ktorrent (~3 megs), amarok (~14 megs),
# kdegames (~23 megs)
digikam
ekiga
-kdeedu
-scribus
ktorrent
hal-cups-utils
system-config-printer
system-config-printer-libs
foomatic
hplip
hpijs
kdebindings
xorg-x11-drv-nouveau

-libgweather
-gnome-panel
-evolution-data-server
-gnome-desktop

# KDE 3
-koffice-kword
-koffice-kspread
-koffice-kpresenter
-koffice-filters
-filelight

# lang support
@chinese-support
#@albanian-support
#@arabic-support
#@assamese-support
#@basque-support
#@belarusian-support
#@bengali-support
#@brazilian-support
#@british-support
#@bulgarian-support
#@catalan-support
#@czech-support
#@danish-support
#@dutch-support
#@estonian-support
#@finnish-support
#@french-support
#@galician-support
#@georgian-support
#@german-support
#@greek-support
#@gujarati-support
#@hebrew-support
#@hindi-support
#@hungarian-support
#@indonesian-support
#@italian-support
#@japanese-support
#@kannada-support
#@korean-support
#@latvian-support
#@lithuanian-support
#@macedonian-support
#@malayalam-support
#@marathi-support
#@nepali-support
#@norwegian-support
#@oriya-support
#@persian-support
#@polish-support
#@portuguese-support
#@punjabi-support
#@romanian-support
#@russian-support
#@serbian-support
#@slovak-support
#@slovenian-support
#@spanish-support
#@swedish-support
#@tamil-support
#@telugu-support
#@thai-support
#@turkish-support
#@ukrainian-support
#@vietnamese-support
#@welsh-support

# avoid weird case where we pull in more festival stuff than we need
festival
festvox-slt-arctic-hts

# save some space
-specspo
-esc
-a2ps
-mpage
-redhat-lsb
-sox
-pidgin
-libpurple

-gnome-user-docs
-gimp-help
-evolution-help
-autofs
-nss_db
-vino
-dasher
-evince-dvi
-evince-djvu
# not needed for gnome
-acpid
# temporary - drags in many deps
-tomboy
-f-spot
-policycoreutils-gui

# dictionaries are big
-aspell-*
-hunspell-*
#-man-pages-*
-scim-tables-*
-wqy-bitmap-fonts
#dejavu-fonts-experimental

# more fun with space saving 
scim-lang-chinese
-scim-python*
scim-chewing
scim-pinyin


# smartcards won't really work on the livecd.  
-coolkey
-ccid
# duplicate functionality
-vorbis-tools
wget
# dasher is just too big
-dasher
# lose the compat stuff
-compat*

xsane
xsane-gimp

# wine packages
wine
wine-capi
wine-cms
wine-core
wine-desktop
wine-esd
wine-jack
wine-ldap
wine-nas
wine-tools
wine-twain

# livecd bits to set up the livecd and be able to install
-anaconda

# make sure debuginfo doesn't end up on the live image
-*debuginfo

# for graphic boot
plymouth-plugin-spinfinity
firstconfig

%end

%post
# FIXME: it'd be better to get this installed from a package
cat > /etc/rc.d/init.d/redflag-live << EOF
#!/bin/bash
#
# live: Init script for live image
#
# chkconfig: 345 00 99
# description: Init script for live image.

. /etc/init.d/functions

if ! strstr "\`cat /proc/cmdline\`" liveimg || [ "\$1" != "start" ] || [ -e /.liveimg-configured ] ; then
    exit 0
fi

exists() {
    which \$1 >/dev/null 2>&1 || return
    \$*
}

touch /.liveimg-configured

# mount live image
if [ -b /dev/live ]; then
   mkdir -p /mnt/live
   mount -o ro /dev/live /mnt/live
fi

# enable swaps unless requested otherwise
swaps=\`blkid -t TYPE=swap -o device\`
if ! strstr "\`cat /proc/cmdline\`" noswap -a [ -n "\$swaps" ] ; then
  for s in \$swaps ; do
    action "Enabling swap partition \$s" swapon \$s
  done
fi

# disable root password
passwd -d root > /dev/null

# add redflag user with no passwd
useradd -c "RedFlag Live CD" redflag
passwd -d redflag > /dev/null

# make redflag user use KDE
echo "startkde" > /home/redflag/.xsession
chmod a+x /home/redflag/.xsession
chown redflag:redflag /home/redflag/.xsession

# set up autologin for user redflag
sed -i 's/#AutoLoginEnable=true/AutoLoginEnable=true/' /etc/kde/kdm/kdmrc
sed -i 's/#AutoLoginUser=fred/AutoLoginUser=redflag/' /etc/kde/kdm/kdmrc

# set up user redflag as default user and preselected user
sed -i 's/#PreselectUser=Default/PreselectUser=Default/' /etc/kde/kdm/kdmrc
sed -i 's/#DefaultUser=johndoe/DefaultUser=redflag/' /etc/kde/kdm/kdmrc

# add liveinst.desktop to favorites menu
mkdir -p /home/redflag/.kde/share/config/
cat > /home/redflag/.kde/share/config/kickoffrc << MENU_EOF
[Favorites]
FavoriteURLs=/usr/share/applications/kde4/systemsettings.desktop,/usr/share/kde-settings/kde-profile/default/share/applications/myHome.desktop,/usr/share/applications/mozilla-firefox.desktop,/usr/share/applications/qq.desktop,/usr/share/applications/dazhihui.desktop,/usr/share/applications/grub-install-guide.desktop,/usr/share/applications/rfinstaller.desktop
MENU_EOF

cat >> /home/redflag/.kde/share/config/plasma-appletsrc << MENU_EOF
//add by pwp 

[Containments][10][Applets][15]
geometry=160,8,160,80
immutability=1
plugin=icon
zvalue=0
[Containments][10][Applets][15][Configuration]
Url=file:///usr/share/applications/grub-install-guide.desktop

[Containments][10][Applets][16]
geometry=160,120,160,80
immutability=1
plugin=icon
zvalue=0
[Containments][10][Applets][16][Configuration]
Url=file:///usr/share/applications/rfinstaller.desktop

//add by pwp end

MENU_EOF

chown -R redflag:redflag /home/redflag/.kde/

# add rfinstaller.desktop and grub-install-guide.desktop to home directory of redflag
#mkdir -p  /home/redflag/桌面/
#mv /root/Desktop/rfinstaller.desktop /home/redflag/桌面/rfinstaller.desktop
#mv /root/Desktop/grub-install-guide.desktop /home/redflag/桌面/grub-install-guide.desktop
#chown -R redflag:redflag /home/redflag/桌面/

chown -R redflag:redflag /home/redflag/.kde

# enable chinese input method
#echo 'export XMODIFIERS="@im=SCIM"' >> /etc/profile

# disable gpgcheck in /etc/yum.conf
sed -i 's/gpgcheck=1/gpgcheck=0/' /etc/yum.conf

# disable fedora kdm theme
sed -i 's/GreetString=Fedora 9 (Sulphur)/GreetString=Red Flag Desktop 7.0 (Olympic)/' /etc/kde/kdm/kdmrc
sed -i 's|Theme=/usr/share/kde4/apps/kdm/themes/FedoraWaves||' /etc/kde/kdm/kdmrc

# turn off firstboot for livecd boots
#chkconfig --level 345 firstboot off 2>/dev/null

# don't start yum-updatesd for livecd boots
chkconfig --level 345 yum-updatesd off 2>/dev/null

# don't do packagekit checking by default
#gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t string /apps/gnome-packagekit/frequency_get_updates never >/dev/null
#gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t string /apps/gnome-packagekit/frequency_refresh_cache never >/dev/null
#gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-packagekit/notify_available false >/dev/null

# apparently, the gconf keys aren't enough
mkdir -p /home/redflag/.config/autostart
echo "X-GNOME-Autostart-enabled=false" >> /home/redflag/.config/autostart/gpk-update-icon.desktop
chown -R redflag:redflag /home/redflag/.config

# don't start cron/at as they tend to spawn things which are
# disk intensive that are painful on a live image
chkconfig --level 345 crond off 2>/dev/null
chkconfig --level 345 atd off 2>/dev/null
chkconfig --level 345 anacron off 2>/dev/null
chkconfig --level 345 readahead_early off 2>/dev/null
chkconfig --level 345 readahead_later off 2>/dev/null

# Stopgap fix for RH #217966; should be fixed in HAL instead
touch /media/.hal-mtab

# workaround clock syncing on shutdown that we don't want (#297421)
sed -i -e 's/hwclock/no-such-hwclock/g' /etc/rc.d/init.d/halt

# because there're some problems to display fonts in a few devices, so we use vesa in this device

cat > /etc/X11/X_blacklist << X_BLACKLIST_EOF
1002:7196 radeonhd
8086:2a12 vesa
8086:29c2 vesa
10de:03d0 nouveau
X_BLACKLIST_EOF

sys_number=\`lspci | grep VGA | cut -d ' ' -f 1\`
numeric_ID=\`lspci -n | grep \$sys_number | cut -d ' ' -f 3\`

#echo creating xorg.conf...
#X -configure > /dev/null 2>&1
## kao, why the configure file is saved as //xorg.conf.new, why not /root/xorg.conf.new ?
#mv -f //xorg.conf.new /etc/X11/xorg.conf
#
#if ( grep -q \$numeric_ID /etc/X11/X_blacklist ) || strstr "\`cat /proc/cmdline\`" safe_X ; then
#   sed -i -e '/Section "Device"/,/EndSection/s/^[[:space:]]*Driver.*/        Driver      "vesa"/' /etc/X11/xorg.conf
#fi
#
## replace nouveau with nv
#sed -i -e '/Section "Device"/,/EndSection/s/^[[:space:]]*Driver[[:space:]]*"nouveau".*/        Driver      "nv"/' /etc/X11/xorg.conf

#### use vesa as default, is it a right choice?
###sed -i -e '/Section "Device"/,/EndSection/s/^[[:space:]]*Driver.*/        Driver      "vesa"/' /etc/X11/xorg.conf
####sed -i -e '/Section "Screen"/,/EndSection/s/^.*24.*/        Depth 24  "1280x1024" "1024x768" "800x600"/' /etc/X11/xorg.conf

# sleep 4 seconds when startkde
#sed -i '5c\sleep 7' /usr/bin/startkde

# run first config before kdm start
#if ! grep "autotest" /proc/cmdline > /dev/null; then
sed -i '4c\plymouth --quit ; fconfig.sh > /dev/null 2>&1 ' /etc/X11/prefdm
#fi

# run rftest if autest parameter is on
if grep "autotest" /proc/cmdline > /dev/null; then
mkdir -p /home/redflag/.kde/Autostart
touch /home/redflag/.kde/Autostart/rftest.sh
chmod +x /home/redflag/.kde/Autostart/rftest.sh
echo "kdesu rftest" >> /home/redflag/.kde/Autostart/rftest.sh
chown -R redflag:redflag /home/redflag/.kde/Autostart
fi

# disable autostart rfpasswd
rm -f /etc/xdg/autostart/rfpasswd.desktop
# disable nepomukserver
rm -f /usr/share/autostart/nepomukserver.desktop
# disable mlocate
rm -f /etc/cron.daily/mlocate.cron
EOF

# bah, hal starts way too late
cat > /etc/rc.d/init.d/redflag-late-live << EOF
#!/bin/bash
#
# live: Late init script for live image
#
# chkconfig: 345 99 01
# description: Late init script for live image.

. /etc/init.d/functions

if ! strstr "\`cat /proc/cmdline\`" liveimg || [ "\$1" != "start" ] || [ -e /.liveimg-late-configured ] ; then
    exit 0
fi

exists() {
    which \$1 >/dev/null 2>&1 || return
    \$*
}

touch /.liveimg-late-configured

# read some variables out of /proc/cmdline
for o in \`cat /proc/cmdline\` ; do
    case \$o in
    ks=*)
        ks="\${o#ks=}"
        ;;
    xdriver=*)
        xdriver="--set-driver=\${o#xdriver=}"
        ;;
    esac
done


## if liveinst or textinst is given, start anaconda
#if strstr "\`cat /proc/cmdline\`" liveinst ; then
#   /usr/sbin/liveinst \$ks
#fi
#if strstr "\`cat /proc/cmdline\`" textinst ; then
#   /usr/sbin/liveinst --text \$ks
#fi

# configure X, allowing user to override xdriver
if [ -n "\$xdriver" ]; then
   exists system-config-display --noui --reconfig --set-depth=24 \$xdriver
fi

EOF

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
DESKTOP="KDE"
DISPLAYMANAGER="KDM"
EOF

# workaround avahi segfault (#279301)
touch /etc/resolv.conf
/sbin/restorecon /etc/resolv.conf

chmod 755 /etc/rc.d/init.d/redflag-live
/sbin/restorecon /etc/rc.d/init.d/redflag-live
/sbin/chkconfig --add redflag-live

chmod 755 /etc/rc.d/init.d/redflag-late-live
/sbin/restorecon /etc/rc.d/init.d/redflag-late-live
/sbin/chkconfig --add redflag-late-live

# work around for poor key import UI in PackageKit
#rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redflag

# save a little bit of space at least...
#rm -f /boot/initrd*
# make sure there aren't core files lying around
#rm -f /core*

# create /etc/yum_livecd.conf for livecd update
cat > /etc/yum_livecd.conf <<EOF
[main]
cachedir=/var/cache/yum
keepcache=0
debuglevel=2
logfile=/var/log/yum.log
exactarch=1
obsoletes=1
gpgcheck=0
plugins=1
metadata_expire=1800
installonly_limit=2

[base]
name=liveCD repository
baseurl=file:///mnt/live/repository/yum/rpmbase

[update]
name=liveCD repository
baseurl=file:///mnt/live/repository/yum/rpmupdate

EOF

## try to make KDM to display earlier
#for i in `/sbin/chkconfig | awk '{print $1}'` ; do
#    /sbin/chkconfig --level 4 $i off
#done
#
#/sbin/chkconfig --level 4 redflag-live on
#
#sed -i 's/id:5:initdefault:/id:4:initdefault:/' /etc/inittab
#
#cat > /etc/event.d/prefdm-4 <<EOF
## prefdm - preferred display manager
##
## Starts gdm/xdm/etc by preference
#
#start on stopped rc4
#
#stop on runlevel [!4]
#
#console output
#respawn
#respawn limit 10 120
#exec /etc/X11/prefdm -nodaemon
#EOF
#
#cat > /etc/event.d/post-services <<EOF
#start on started prefdm-4
#
#exec /etc/rc.d/rc 5
#EOF

for i in `/sbin/chkconfig | awk '{print $1}'` ; do
    /sbin/chkconfig --level 4 $i off
done
/sbin/chkconfig --level 4 redflag-live on

# end try to make KDM to display earlier

passwd -d root >/dev/null 2>&1
/sbin/chkconfig --level 4 redflag-live on
#/sbin/chkconfig --level 4 messagebus on
#/sbin/chkconfig --level 2345 sendmail off

# default use sam for pam
sed -i 's/password    sufficient    pam_unix.so md5 shadow nullok try_first_pass use_authtok/password    sufficient    pam_unix.so sam shadow nullok try_first_pass use_authtok/' /etc/pam.d/system-auth

# fix "pm-hibernate -quirk-vbe-post" does NOT make the system enter S4
#ln -s /boot/grub/grub.conf /etc/grub.conf

# do something to disable pam_cracklib
sed -i 's/password    requisite     pam_cracklib.so try_first_pass retry=3/#password    requisite     pam_cracklib.so try_first_pass retry=3/' /etc/pam.d/system-auth-ac
sed -i 's/password    sufficient    pam_unix.so sam shadow nullok try_first_pass use_authtok/password    sufficient    pam_unix.so sam shadow nullok try_first_pass/' /etc/pam.d/system-auth-ac

# create /etc/redflag-release
BIRTHDAY=$(date +%m%d)
ORIG_RELEASE=`cat /etc/redflag-release`
RELEASE="$ORIG_RELEASE -- $BIRTHDAY"
echo $RELEASE > /etc/redflag-release

# add by pwp
# use the locale file to add/delete some package.
mkdir -p /usr/share/apps/rfpackages_conf/
cat > /usr/share/apps/rfpackages_conf/rfpackages.locale << EOF
#               FORMAT
#               description after a '#'
#               locale=en_US.UTF-8
#               del_packages=p1,p2,p3 ...
#               add_packages=p4,p5,p6 ...
#
#               locale=zh_CN.UTF-8
#               del_packages=p1,p2,p3 ...
#               add_packages=p4,p5,p6 ...
#
# del or add some packages according to locale
locale=en_US.UTF-8
del_packages=linuxqq

EOF
# add by pwp end

%end

%post --nochroot

# graphic boot start
INITRD0_DIR=tmp_initrd0
rm -rf $INITRD0_DIR
mkdir $INITRD0_DIR && cd $INITRD0_DIR
gzip -dc $LIVE_ROOT/isolinux/initrd0.img | cpio -idmv

rm -rf tmp_for_ext3fs
mkdir -p tmp_for_ext3fs
mount -o loop /var/tmp/imgcreate-*/tmp*/ext3fs.img tmp_for_ext3fs

## set for plymouth
#cp -f ../plymouth.png ./usr/share/pixmaps/system-logo-white.png
cp -ar tmp_for_ext3fs/usr/lib/plymouth/spinfinity.so usr/lib/plymouth/
rm -f usr/lib/plymouth/default.so
(cd usr/lib/plymouth/ && ln -s spinfinity.so default.so)

umount tmp_for_ext3fs
rmdir tmp_for_ext3fs

find . | cpio --quiet -c -o | gzip -9 -n > $LIVE_ROOT/isolinux/initrd0.img

cd ..

# graphic boot end

# do something for disk boot
#( cd ../initrd4disk/initrd4disk-2.6.27-0.322.rc6.dt7.i686/ && find . | cpio --quiet -c -o | gzip -9 -n > $LIVE_ROOT/isolinux/initrd4disk.img )

# create initrd4disk start

INITRD4DISK_DIR=tmp_initrd4disk
rm -rf $INITRD4DISK_DIR
mkdir $INITRD4DISK_DIR && cd $INITRD4DISK_DIR
gzip -dc $LIVE_ROOT/isolinux/initrd0.img | cpio -idmv
#cp -f ../initrd4disk/sbin/real-init sbin/real-init
#cp -ar ../initrd4disk/sbin/mount.ntfs* sbin/
#cp -ar ../initrd4disk/lib/libntfs-3g* lib/
KERNEL_VERSION=$(/bin/ls lib/modules/)
echo $KERNEL_VERSION

rm -rf tmp_for_ext3fs
mkdir -p tmp_for_ext3fs
mount -o loop /var/tmp/imgcreate-*/tmp*/ext3fs.img tmp_for_ext3fs

cp -f ../real-init.disk sbin/real-init
cp -ar tmp_for_ext3fs/sbin/mount.ntfs* sbin/
cp -ar tmp_for_ext3fs/lib/libntfs-3g* lib/

cp tmp_for_ext3fs/lib/modules/$KERNEL_VERSION/kernel/fs/fuse/fuse.ko lib/modules/$KERNEL_VERSION/fuse.ko

umount tmp_for_ext3fs
rmdir tmp_for_ext3fs

/sbin/depmod -b . $KERNEL_VERSION
find . | cpio --quiet -c -o | gzip -9 -n > $LIVE_ROOT/isolinux/initrd4disk.img

cd ..

# create initrd4disk end

# create initrd4net start
INITRD4NET_DIR=tmp_initrd4net
rm -rf $INITRD4NET_DIR
mkdir $INITRD4NET_DIR && cd $INITRD4NET_DIR
gzip -dc ../initrd4net.img | cpio -idmv

rm -rf tmp_for_ext3fs
mkdir -p tmp_for_ext3fs
mount -o loop /var/tmp/imgcreate-*/tmp*/ext3fs.img tmp_for_ext3fs
cp -ar tmp_for_ext3fs/lib/modules/$KERNEL_VERSION/ lib/modules/
umount tmp_for_ext3fs
rmdir tmp_for_ext3fs

find . | cpio --quiet -c -o | gzip -9 -n > $LIVE_ROOT/isolinux/initrd4net.img

cd ..

# create initrd4net end

cat > $LIVE_ROOT/isolinux/硬盘启动帮助文档.txt <<EOF
硬盘启动livecd的原理主要是通过改变initrd中的init文件
使系统将原先挂载光驱的步骤改为挂载硬盘上指定的iso，
并修改相应的启动步骤来达到。

例如要启动的livecd文件放在分区/dev/sda2上, 并且/dev/sda2/挂载为/mnt/sda2，
即有文件/mnt/sda2/redflag-DT7-liveCD-200808080800.iso
从iso中提取出文件vmlinuz0和initrd4disk.img，将其放在/mnt/sda2下，
此时/mnt/sda2下面有文件:
redflag-DT7-liveCD-200808080800.iso，vmlinuz0，initrd4disk.img

则grub 相应的配置文件为:

title disk boot DT7
root (hd0,1)
kernel /vmlinuz0 root=CDLABEL=redflag-DT7-livecd isodev=/dev/sda2 isodev_dir=/ rootfstype=iso9660 ro liveimg quiet vga=788 live_locale=zh_CN.UTF-8
initrd /initrd4disk.img

------------------------------------------------------

Good luck!

EOF

cat > $LIVE_ROOT/readme.txt <<EOF
hdboot.sh is a disk boot tool for linux,
usb-live-tools.sh is tool which give you a usb-live disk,
and rfsetup.exe is a disk boot and usb-live tool for windows.

Enjoy Hacking!

EOF

# copy hdboot utils to iso
(cd hdboot && svn up)
#mkdir -p $LIVE_ROOT/disk_boot_utils
#mkdir -p $LIVE_ROOT/disk_boot_utils/for_linux
#mkdir -p $LIVE_ROOT/disk_boot_utils/for_windows

#cp -a hdboot/hdboot.sh $LIVE_ROOT/disk_boot_utils/for_linux
#cp -a hdboot/hdbootwin/Release/rfsetup.exe $LIVE_ROOT/disk_boot_utils/for_windows
cp -a hdboot/hdboot.sh $LIVE_ROOT/
cp -a hdboot/hdbootwin/Release/rfsetup.exe $LIVE_ROOT/
cp -a usb-live-tool.sh $LIVE_ROOT/

# use gfx for isolinux
#cp -ar ./gfx_redflag_livecd/isolinux/* $LIVE_ROOT/isolinux/

%end
