#!/bin/sh -e
BUNDLE_CONFIG="./bundle-config/bundle.config.json"
sim=0
dir=""
dev=0
ipaddr=""
usage()
{
    echo "usage: ./tools/deploy.sh [[-s --simulator-only] [-o --output-dir] [-i --ip-addr]  [-h --help]]"
    echo "example: ./tools/deploy.sh -i 192.168.1.43"
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
          -i | --ip-addr )             shift
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

SCRIPT_BASE=./dist/default
SCRIPT_FILE=$SCRIPT_BASE/beaconRecipes.script



if [ $sim = 0 ]; then
  if [ -z $ipaddr ]; then
    echo "************************************************************************************"
    echo "ERROR: Please use the -i flag to enter a valid IP Address for the robot. See example usage:"
    echo ""
    usage
    echo "************************************************************************************"
    exit 1
  fi
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