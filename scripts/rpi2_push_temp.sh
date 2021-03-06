#!/bin/bash

#Get scriptdir for external script call
readlink -f "$0"
scriptdir=$(dirname $0)

#Call python script for temperature sensor reading and read variable
read temp_intake <<< $(/usr/bin/python $scriptdir/python/rpi2_readtemp.py)

#Upload data to to InfluxDB
curl -i -XPOST 'http://192.168.1.120:8086/write?db=home&precision=s' --data-binary "temp,host=rpi2,sensor=intake value=$temp_intake"
