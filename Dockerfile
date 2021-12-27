# base stage
FROM alpine AS base
RUN apk add --no-cache font-noto wireshark firefox irssi

# router stage
FROM base AS router
RUN apk add --no-cache frr openvpn
COPY docker/frr/daemons /etc/frr/daemons
COPY docker/frr/docker-start /usr/lib/frr/docker-start
COPY docker/frr/frr-save /usr/local/bin/frr-save
RUN mkdir -p /run/frr && chown -R frr:frr /run/frr
ENTRYPOINT /data/init.sh; exec /usr/lib/frr/docker-start

# client stage
FROM base AS client
RUN apk add --no-cache dhclient
ENTRYPOINT /scripts/init.sh; exec sleep infinity

# ISP box with dhcp
FROM router AS box
RUN apk add --no-cache dhcp
COPY docker/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf


# Clients Asterisk
FROM debian AS asteriskClients
  # Linphone est un logiciel de VoIP qui fonctionne comme Skype
RUN apt install linphone

