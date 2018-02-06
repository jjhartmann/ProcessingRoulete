#! /bin/bash

if [ $# > 0 ]
then
    arg1="$1"
else 
    arg1="/Files/"
fi

if [ $# > 1 ]
then
    arg2=$2
else
    arg2=5
fi

if [ $# > 2 ]
then 
    arg3=$3
else
    arg3=5
fi

echo "########################################"
echo "STARTING APPLICATION: PROCESSING ROULETE"
echo "Location: $arg1"
echo "Minutes:  $arg2"
echo "########################################"
echo ""

applications=( $(find $arg1 -name *.app) )
# echo "${applications[@]}"

# while [ 1 ]
# do 
    for filename in ${applications[@]}; do
        echo "########################################"
        echo "Opening Project: $filename"
        echo "########################################"
        echo ""
        
        app=$(ls $filename/Contents/MacOS/)
        exec $filename/Contents/MacOS/$app & TASK_PID=$!

        echo "TASK PID: $TASK_PID"
        echo ""

        # countdown timer
        sleep $arg2
        echo "########################################"
        echo "Closing Project: $filename"
        echo "########################################"
        echo ""
        
        pkill $app

        sleep $arg3
    done
# done