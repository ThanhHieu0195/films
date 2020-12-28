#!/bin/bash

m3u8Clone() {
	echo "clonning ..."
	echo "$1"
	videoName=$1
	videoName=$videoName  node downloadPhim.js
	notify-send "DONE!!! $videoName"
}

m3u8Files=$(ls m3u8s/*m3u8)
for url in ${m3u8Files}
do 
		fileName=$(echo $url|sed 's/m3u8s\///g'|sed 's/.m3u8//g')
		isCheck=$(cat logs/downloaded.txt |grep $fileName)
		if [ -z "$isCheck" ]; then 
			echo "type m3u8"
			m3u8Clone "$fileName"
			
			date +'%d-%m-%y %H:%M:%S' >> ./logs/downloaded.txt
			echo "$fileName.m3u8" >> ./logs/downloaded.txt
		fi
done

arr=$(cat data_mp4.txt)
for url in ${arr[@]}
do
	isCheck=$(cat logs/downloaded.txt |grep $url)
	if [ -z "$isCheck" ]; then 
		echo "processing ... $url"
		echo "type mp4"
		echo "Fetch ... $url"
		wget "$url"
		echo ""
		echo "DONE!!! $url"
		
		date +'%d-%m-%y %H:%M:%S' >> ./logs/downloaded.txt
		echo $url >> ./logs/downloaded.txt
	fi
done