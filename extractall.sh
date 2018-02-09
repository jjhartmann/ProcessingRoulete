#! /bin/bash
if (( $# < 1 )) 
then
    echo "########################################"
    echo "Must provide watch folder and destination"
    echo "########################################" 
    exit 0  
fi

sourcefolder=$1
echo $sourcefolder

destination=$2
echo $destination

echo "########################################"
echo "Extracting content"
echo "########################################" 

files=( $(find $sourcefolder -name *.zip) )
echo ${files[@]}

for filename in ${files[@]}; do
    echo "tar -xvf $filename $destination"
done