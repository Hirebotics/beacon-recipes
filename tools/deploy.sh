#!/bin/sh -e
BUNDLE_CONFIG="./bundle-config/bundle.config.json"
sim=0
dir=""
dev=0
ipaddr="192.168.181.149"
ipaddr_dev="192.168.181.150"
usage()
{
    echo "usage: deploy [[-s --simulator-only] [-o --output-dir] [-l --list list]  [-h --help]]"
    echo "example: deploy -i 192.168.1.43"
}


#Check to see if sshpass is installed on the host machine, if it is not we will install it
if command -v sshpass >/dev/null 2>&1; then 
  echo "SSHPASS Installed" 
  echo ""
else
  /usr/local/bin/brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb 

fi

  while [ "$1" != "" ]; do
      case $1 in
          -i | --ip )             shift
                                  ipaddr=$1
                                  ;;
          -s | --simulator-only ) sim=1
                                  ;; 
          -o | --output-dir )     shift       
                                  dir=$1
                                  ;;                                                                         
          -h | --help )           usage
                                  exit
                                  ;;            
      esac
      shift
  done

# bundle all configs
npm run dist

SCRIPT_BASE=./dist
SCRIPT_FILES=$SCRIPT_BASE/*.script
SCRIPT_FILE=$SCRIPT_BASE/scripts.script

if [ $sim = 0 ]; then
  echo "Directory: " $dir
  if [ ! -z $dir ]; then
    echo "************************************************************************************"
    echo "ERROR:  Cannot use the --output-dir flag when in regular mode, flag has been ignored"
    echo "************************************************************************************"
  fi  
  # Copy script.script to the robot
  echo "Copying scripts to the robot"
  sshpass -p easybot scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $SCRIPT_FILE  root@$ipaddr:/programs/
  echo "popup New Script Ready to Try" | nc $ipaddr 29999
 else 
   if [ ! -z $dir ]; then
     cp $SCRIPT_FILE $dir
   fi
   echo "************************************************************************************"    
   echo "Simulator Only Mode.  Files are ready to use"
   echo "************************************************************************************"
 fi   