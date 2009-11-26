# use Menu(keycode 117) to simulate Pointer_Button2
setxkbmap -layout us
xkbset m #打开mousekeys开关，使系统能够把敲键事件变为点击事件
xkbset exp =m #当超出(expire)默认的事件间隔后，仍然保留(=)mousekeys(m)特性
xmodmap -e 'keycode 117 = Pointer_Button2'
