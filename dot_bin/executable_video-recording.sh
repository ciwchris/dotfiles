#!/bin/sh

eval set -- $(getopt -n $0 -o "-cswy:" -- "$@")

declare c s w y
declare -a files
while [ $# -gt 0 ] ; do
	case "$1" in
		-c) c=1 ; shift ;;
		-s) s=1 ; shift ;;
		-w) w=1 ; shift ;;
		-y) y=1 ; shift ;;
		--) shift ;;
		-*) echo "bad option '$1'" ; exit 1 ;;
		*) files=("${files[@]}" "$1") ; shift ;;
	esac
done

if [ ${#files[@]} -ne 1 ] ; then
	echo one file name required
	exit 1
fi

#convert video to webm
[ ! -z "$c" ] && ffmpeg -y -i ${files[0]} -c:a libvorbis -q:a 3 -c:v libvpx -b:v 2000k ${files[0]}.webm

#start screencast
[ ! -z "$s" ] && ffmpeg -f x11grab -r 24 -video_size 1366x768 -i :0.0 -vcodec libx264 ${files[0]}.mkv
#[ ! -z "$s" ] && ffmpeg -f x11grab -r 30 -video_size 1366x768 -i :0.0 -f alsa -i hw:0,0 -acodec flac -vcodec libx264 ${files[0]}.mkv

#start webcam
[ ! -z "$w" ] && ffmpeg -f v4l2 -s 1366x768 -i /dev/video0 -f alsa -i hw:0,0 -acodec flac -vcodec libx264 ${files[0]}.mkv

# Convert videos for YouTube
# See also https://bbs.archlinux.org/viewtopic.php?pid=1200542#p1200542
[ ! -z "$y" ] && ffmpeg -i ${files[0]} -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p -c:a copy ${files[0]}.mkv
