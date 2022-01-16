#!/bin/sh
set -x

ip r r default via 120.0.24.2
iptables --policy FORWARD DROP
iptables --policy INPUT ACCEPT
iptables --policy OUTPUT ACCEPT
iptables -A FORWARD -s  192.168.255.0/255.255.255.0 -j ACCEPT
iptables -A FORWARD -s 120.0.28.0/24 -j ACCEPT 
iptables -A FORWARD -s 120.0.16.10 -d 120.0.28.10 -j ACCEPT
