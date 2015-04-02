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

if [ -e /usr/sbin/koha-list ]
then # Set up for git sites
    STOPCMD='for instance in $(sudo koha-list --enabled); do sudo koha-stop-sip $instance 2>&1 > /dev/null; done'
    STARTCMD='for instance in $(sudo koha-list --enabled); do sudo koha-start-sip $instance 2>&1 > /dev/null; done'
else # Set up for package sites
    check_dependency "$HOME/sip-daemon.sh"
    STOPCMD="sudo $HOME/sip-daemon.sh stop 2>&1 > /dev/null"
    STARTCMD="sudo $HOME/sip-daemon.sh start 2>&1 > /dev/null"
fi


# Request a graceful shutdown of all running SIP processes

eval "$STOPCMD"

sleep 10;

for pid in $(pgrep -f SIP)
do
    sudo kill $pid || sudo kill -9 $pid
done

sleep 10;

if process="$(pgrep -f SIP)"
then
    echo "Un-killable SIP process(es): $process"
    exit 1
fi

# Restart SIP

eval "$STARTCMD"

if ! pgrep -c -f SIP 2>&1 > /dev/null
then
    echo "$0: SIP did not re-start successfully."
    exit 1
fi
