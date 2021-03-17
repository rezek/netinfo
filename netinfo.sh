#!/usr/bin/env bash
#
# netinfo.sh - Extract relevant information about network parameters
#
# Autor:        Diego Rezek
# Maintenence:  Diego Rezek
#
# ------------------------------------------------------------------------ #
# Tested in:
#   bash 5.0.17
# ------------------------------------------------------------------------ #
# ------------------------------- VARIABLES ----------------------------------------- #
HELP="
  $(basename $0) - [OPTIONS]
  -i - Show IP Address
  -m - Show MAC Address
  -g - Show Gateway
  -d - Show DNS
  -pg - Ping to Gateway
  -pd - Ping to DNS
"
GATEWAY=$(ip route | grep via | cut -d a -f 3 | cut -d d -f 1)
DNS=$(cat /etc/resolv.conf | grep nameserver | cut -d r -f 3)
IP=$(nmcli | grep inet4 | cut -d / -f 1 | cut -d 4 -f 2)
MAC=$(nmcli | grep ethernet | cut -d , -f 2)

# ------------------------------- EXECUTION ----------------------------------------- #
case "$1" in
  -h) echo "$HELP" && exit 0              ;;
  -i) echo "IP Address: $IP" && exit 0    ;;
  -m) echo "MAC Address: $MAC" && exit 0  ;;
  -d) echo "DNS: $DNS" && exit 0          ;;
  -g) echo "Gateway: $GATEWAY" && exit 0  ;;
  -pg) ping $GATEWAY -c 4 && exit 0       ;;
  -pd) ping $DNS -c 4 && exit 0           ;;
  *) echo "Invalid parameter, try $0 -h" && exit 1   ;;
esac

# ------------------------------- EXECUÇÃO ----------------------------------------- #
