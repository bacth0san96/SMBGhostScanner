#!/bin/bash
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
#Code by bacth0san >.<

while getopts "t:" OPTION; do
        case "${OPTION}" in
         t) target="${OPTARG}";;
        esac
done
   
if [[ "$target" > "0" ]]; then 
	echo "Checking for SMB v3.11 in $target ..."
	result=$(nmap -p445 --script smb-protocols -Pn -n $target  | grep -o 3.11) 

	if [[ "$result" == '3.11' ]]; then
                echo -e "$target - ${RED}FOUND 3.11 VERSION - POSSIBLY VULNERABLE TO CVE-2020-0796" ${NC}
        else
		echo -e "$target - ${GREEN}There is no SMB v3.11 - possibly not vulnerable (Port 445 can be filtered or closed)"  ${NC}
	fi
else
	echo -e "${RED}USAGE: bash CVE-2020-0796-Checker.sh -t IP${NC}"
fi

