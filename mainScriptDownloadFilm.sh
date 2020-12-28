#!/bin/bash

m3u8Clone() {
	echo "clonning ..."
	echo "$1"
	videoName=$1
	videoName=$videoName  node downloadPhim.js
	notify-send "DONE!!! $videoName"
}

m3u8Files=$(ls *m3u8)
for url in ${m3u8Files}
do 
		echo "type m3u8"
		fileName=$(echo $url|sed 's/.m3u8//g')
		m3u8Clone "$fileName"
		echo ""
		echo $url >> downloaded.txt
		mv $url ./archived/$url
done

arr=(
	'https://ivnmovie.b-cdn.net//movies//19-03-2020/2HitmanAgentJun/SatThuVoCungCucHitmanAgentJunFullHD.mp4'
	'https://cdn.janji.ru//movies/19-11-2019/Di%E1%BB%87p%20V%E1%BA%A5n%203%20-%20Ip%20Man%203%20/Di%E1%BB%87p%20V%E1%BA%A5n%203%20-%20Ip%20Man%203%20-%20Full%20HD.mp4'
	'https://cdn.janji.ru//movies/21-12-2019/The%20Amazing%20Spiderman%20(2012)/The.Amazing.Spiderman.2012.720p.BrRip.x264.YIFY.mp4'
	'https://cdn.janji.ru//movies/19-12-2019/The%20Amazing%20Spider%20Man%202%20(2014)/The.Amazing.Spider.Man.2.2014.720p.BluRay.x264.YIFY.mp4'
	'https://ivnmovie.b-cdn.net//movies/30042020/Spiderman/Spiderman.mp4'
	'https://ivnmovie.b-cdn.net//movies/30042020/Spiderman2/Spiderman2.mp4'
	'https://ivnmovie.b-cdn.net//movies/30042020/Spiderman3/Spiderman3.mp4'
	'ttps://cdn.janji.ru//movies/07-01-2020/The%20Twilight%20Saga%20Breaking%20Dawn%20-%20Part%201%20(2011)/The.Twilight.Saga.Breaking.Dawn.Part%201.2011.720p.BrRip.x264.YIFY.mp4'
	'https://cdn.janji.ru//movies/07-01-2020/The%20Twilight%20Saga%20Breaking%20Dawn%20Part%202%20(2012)/The.Twilight.Saga.Breaking.Dawn.Part.2.2012.720p.BRrip.x264.GAZ.YIFY.mp4'
	'https://ivnmovie.b-cdn.net//movies/08052020/DeathRace/DeathRace.mp4'
	'https://ivnmovie.b-cdn.net//movies/09052020/DeathRace2/DeathRace2.mp4'
	'https://ivnmovie.b-cdn.net//movies/09052020/DeathRace3/DeathRace3.mp4'
)
for url in ${arr[@]}
do
	echo "type mp4"
	echo "Fetch ... $url"
	wget "$url"
	notify-send "DONE!!! $url"
	echo ""
	echo $url >> downloaded.txt
done