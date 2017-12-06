#!/bin/bash

# copy from https://gist.github.com/irazasyed/a7b0a079e7727a4315b9

read -p "What is the url of todays gift for .se?" gift
GIFT_OF_THE_DAY_URL_se=$gift
read -p "What is the url of todays gift for .de?" gift
GIFT_OF_THE_DAY_URL_de=$gift
read -p "What is the url of todays gift for .fi?" gift
GIFT_OF_THE_DAY_URL_fi=$gift
read -p "What is the url of todays gift for .dk?" gift
GIFT_OF_THE_DAY_URL_dk=$gift
read -p "What is the url of todays gift for .no?" gift
GIFT_OF_THE_DAY_URL_no=$gift

rest_IPs=("cccc.cccc.cccc.cccc" "cccc.cccc.cccc.cccc" "cccc.cccc.cccc.cccc" "cccc.cccc.cccc.cccc")
dk_IPs=("aaaa.aaaa.aaaa.aaaa" "aaaa.aaaa.aaaa.aaaa")
domains=("se" "de" "fi" "no" "dk")

# PATH TO YOUR HOSTS FILE
ETC_HOSTS=/etc/hosts
for domain in "${domains[@]}"; do
    if [ "$domain" = "dk" ]; then
        for ip in "${dk_IPs[@]}"; do
            addhost $ip "www.xxx.dk"
            curl --request GET "http://www.xxx.dk/$GIFT_OF_THE_DAY_URL_dk?flushAllCache=1"
            removehost $ip "www.xxx.dk"
        done
    else
        for ip in "${rest_IPs[@]}"; do
            addhost $ip "www.xxx."$domain
            case $domain in
                "se")
                curl --request GET "http://www.xxx.$domain/$GIFT_OF_THE_DAY_URL_se?flushAllCache=1"
                ;;
                "de")
                curl --request GET "http://www.xxx.$domain/$GIFT_OF_THE_DAY_URL_de?flushAllCache=1"
                ;;
                "fi")
                curl --request GET "http://www.xxx.$domain/$GIFT_OF_THE_DAY_URL_fi?flushAllCache=1"
                ;;
                "no")
                curl --request GET "http://www.xxx.$domain/$GIFT_OF_THE_DAY_URL_no?flushAllCache=1"
                ;;
            esac
            removehost $ip "www.xxx."$domain
        done
    fi;
done

removehost() {
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
    then
        echo "$HOSTNAME Found in your $ETC_HOSTS, Removing now...";
        sudo sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS
    else
        echo "$HOSTNAME was not found in your $ETC_HOSTS";
    fi
}

addhost() {
    IP=$1;
    HOSTNAME=$2;
    HOSTS_LINE="$IP\t$HOSTNAME"
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
    then
        echo "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
    else
        echo "Adding $HOSTNAME to your $ETC_HOSTS";
        sudo -- sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts";

        if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
        then
            echo "$HOSTNAME was added succesfully \n $(grep $HOSTNAME /etc/hosts)";
        else
            echo "Failed to Add $HOSTNAME, Try again!";
        fi
    fi
}
