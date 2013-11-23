#!/bin/bash
echo $1
FILE_DIR=/data/local/tmp 
cd /data/local/tmp
export LD_LIBRARY_PATH=/data/local/tmp:$LD_LIBRARY_PATH
echo "Current dir:"
echo `pwd`
chmod 0777 trinityexe
./trinityexe -c ioctl -C 1 --dangerous -V $1

#echo `pwd`
#echo $1>>current_node.txt
#chmod 0777 trinityexe
#var='trinity'
#echo $var_$2
#dir=$var_$2
#echo $dir
#mkdir $dir
#echo `pwd`
#cp trinityexe $dir
#cp libqfast.so $dir
#cp libfuzzxmlparser.so $dir
#cp qfastfield_param.xml $dir
#cp qfastfield_grammar.xml $dir
#cd $dir


#FILE_DIR=/data/local/tmp 
#su
#c=1
#while true
#do
#	chmod 0777 /data/busybox/busybox
#	ls -al /data/busybox/busybox
#	file_name=lsof_$c.txt
#	lsof | /data/busybox/busybox awk '{ print $9}'>$FILE_DIR/$file_name
#	((c++))

#	FILENAME=$FILE_DIR/$file_name

#	cat $FILENAME | while read LINE
#	do
#	        let count++
#	    echo "$LINE"    
#		cd /data/local/tmp
#		chmod 0777 *
#		chmod 0777 trinityexe
		
#		if [[ $LINE == "/dev/null" ]];
#		then
#			echo "/dev/null"
#			continue
#		fi
#		
#		if [[ $LINE == "/dev/null" ]];
#		then
#			echo "/dev/__null__"
#
#			continue
#		fi
		
#		if [[ $LINE == "/dev/*" ]];
#		then
#			echo "Running trinity on $LINE node"
#			echo $LINE>>$FILE_DIR/current_node.txt
#			./trinityexe -c ioctl -C 1 --dangerous -V $1
#		fi
#	done
#done