#! /bin/bash
# ./main.sh ./Files/ 10 ./TransitionScreen/application.macosx/TransitionScreen.app/Contents/Java/data/
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
echo "Location:  $arg1"
echo "Seconds:   $arg2"
echo "TempFiles: $arg3"
echo "########################################"
echo ""



while [ 1 ]
do 
    applications=( $(find $arg1 -name *.app) )
    echo "${applications[@]}"
    
    for filename in ${applications[@]}; do

        echo "########################################"
        echo "STATING TRANSITION"
        echo "########################################"
        echo ""
        info=$filename/../info.txt
        cp $info $arg3/info.txt

        screencapture $arg3/screenshot.jpg

        exec ./TransitionScreen/application.macosx/TransitionScreen.app/Contents/MacOS/TransitionScreen & T_PID=$!
        sleep 10

        echo "########################################"
        echo "Opening Project: $filename"
        echo "########################################"
        echo ""
        
        app=$(ls $filename/Contents/MacOS/)
        exec $filename/Contents/MacOS/$app & TASK_PID=$!

        echo "TASK PID: $TASK_PID"
        echo ""

        # sleep 5

        # countdown timer
        sleep $arg2
        
        echo "########################################"
        echo "STATING TRANSITION"
        echo "########################################"
        echo ""
        info=$filename/../info.txt
        cp $info $arg3/info.txt

        screencapture $arg3/screenshot.jpg

        exec ./TransitionScreen/application.macosx/TransitionScreen.app/Contents/MacOS/TransitionScreen & T_PID=$!
        sleep 10

        echo "########################################"
        echo "Closing Project: $filename"
        echo "########################################"
        echo ""

        pkill $app
    done
done
