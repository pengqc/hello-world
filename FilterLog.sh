#/bin/bash

num=1
oldfilename=$1    #参数1为原文件
newfilename=$2    #参数2为过滤后产生的新文件
pathlog="/tmp/log/err.log"

if [ ! -f $oldfilename ]
then
   echo "the $oldfilename file is not found" >> pathlog 
   exit 1
fi

cp $oldfilename $newfilename
  
while read  line 
do
{    
     case "$line" in
     *xm*publickey*) 
        sed -i  ''$num's/publickey for .* from/publickey for ATD-'$RANDOM' from/g' "$newfilename"
        ;;
     *xm*opened*)
        sed -i  ''$num's/user .* by/user ATD-'$RANDOM' by/g' "$newfilename"
        ;;
     *xm*closed*)        
        sed -i  ''$num's/user .*/user ATD-'$RANDOM'/g' "$newfilename"
        ;; 
     esac

     let "num++"
}
done < "$newfilename"

exit 0
