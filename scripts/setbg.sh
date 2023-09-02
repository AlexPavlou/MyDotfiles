#!/bin/sh

today=$(date +"%a")

case $today in
Mon)
wbg "/home/alex/.config/bg/mon.jpg"
;;
Tue)
wbg "/home/alex/.config/bg/tue.jpg"
;;
Wed)
wbg "/home/alex/.config/bg/wed.jpg"
;;
Thu)
wbg "/home/alex/.config/bg/thu.jpg"
;;
Fri)
wbg "/home/alex/.config/bg/fri.jpg"
;;
Sat)
wbg "/home/alex/.config/bg/sat.jpg"
;;
Sun)
wbg "/home/alex/.config/bg/sun.jpg"
;;
*)
;;
esac
