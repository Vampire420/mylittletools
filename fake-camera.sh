sudo modprobe v4l2loopback
sleep 0.5
clear
echo ""
v4l2-ctl --list-devices
read -e -p " [ex. 1,2,3] Enter Dummy video device number: " source
echo ""
sleep 1
echo "		[ 1 ] Desktop-Stream		[ 2 ] Static Picture"
read -p " Option: " option

if [ $option = 1 ]; then
echo ""
xrandr | grep Screen
echo ""
read -e -p " Set resolution: " res
ffmpeg -f x11grab -r 30 -s $res -i :0.0+0,0 -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video$source

elif [ $option = 2 ]; then
read -e -p " Picture Location: " location
ffmpeg -loop 1 -re -i $location -f v4l2 -vcodec rawvideo -pix_fmt yuv420p /dev/video$source
fi
