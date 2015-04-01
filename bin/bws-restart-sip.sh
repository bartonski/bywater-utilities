#! /bin/sh

PATH="$PATH:/usr/sbin:/usr/bin"

# SIP restart script -- should be portable across both git and 
# packge sites.
#
# The script will do the following:
#
# Request a graceful shutdown of all running SIP processes
# Sleep for 10 seconds to allow processes to time to end
# Run pgrep to check for running SIP processes
# Kill any SIP processes which did not shut down gracefully
# Restart SIP

# This script should be run either as the koha user for git sites

# Dependencies
#  /usr/bin/pgrep
#  /usr/bin/pkill

check_dependency() {
    if [ ! -e "${1}" ]
    then
        echo "$0 missing dependency '$1'"
        exit 1
    fi
}

check_dependency /usr/bin/pgrep
check_dependency /usr/bin/pkill

if [ -f /usr/sbin/koha_list ]
then # Set up for git sites
    STOPCMD="koha-foreach --enabled koha-stop-sip"
    STARTCMD="koha-foreach --enabled koha-start-sip"
else # Set up for package sites
    check_dependency "$HOME/sip-daemon.sh"
    STOPCMD="$HOME/sip-daemon.sh stop"
    STARTCMD="$HOME/sip-daemon.sh start"
fi


# Request a graceful shutdown of all running SIP processes

$STOPCMD

sleep 10;

for pid in $(pgrep -f SIP)
do
    kill $pid || kill -9 $pid
done

if process="$(pgrep -f SIP)"
then
    echo "Un-killable SIP process(es): $process"
    exit 1
fi

# Restart SIP

$STARTCMD

if ! pgrep -c -f SIP
then
    echo "$0: SIP did not re-start successfully."
    exit 1
fi
