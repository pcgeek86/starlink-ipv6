#!/bin/bash
echo ERX5 IPv6 Autoconfiguration script launching…

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
cfg=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper
run=/opt/vyatta/bin/vyatta-op-cmd-wrapper

$cfg begin
$cfg set firewall ipv6-name WAN_INBOUND_6 default-action drop
$cfg set firewall ipv6-name WAN_INBOUND_6 description WAN_INBOUND_6
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 10 action accept
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 10 description "Accept Established/Related"
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 10 protocol all
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 10 state established enable
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 10 state related enable
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 20 action accept
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 20 description "Accept ICMP"
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 20 protocol icmpv6
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 30 action drop
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 30 protocol all
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 30 state invalid enable
$cfg set firewall ipv6-name WAN_INBOUND_6 rule 30 description "Drop Invalid state"
$cfg set interfaces ethernet eth0 firewall in ipv6-name WAN_INBOUND_6
$cfg set firewall ipv6-name WAN_LOCAL_6 default-action drop
$cfg set firewall ipv6-name WAN_LOCAL_6 description WAN_LOCAL_6
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 10 action accept
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 10 description "Accept Established/Related"
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 10 protocol all
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 10 state established enable
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 10 state related enable
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 20 action accept
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 20 description "Accept ICMPv6"
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 20 protocol icmpv6
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 30 action accept
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 30 description "Accept DHCPv6"
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 30 protocol udp
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 30 destination port 546
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 30 source port 547
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 40 action drop
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 40 protocol all
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 40 state invalid enable
$cfg set firewall ipv6-name WAN_LOCAL_6 rule 40 description "Drop Invalid state"
$cfg set interfaces ethernet eth0 firewall local ipv6-name WAN_LOCAL_6
#Configure DHCP-PD
$cfg set interfaces ethernet eth0 dhcpv6-pd prefix-only
$cfg set interfaces ethernet eth0 dhcpv6-pd pd 0 prefix-length 56
$cfg set interfaces ethernet eth0 dhcpv6-pd pd 0 interface switch0 prefix-id :1
$cfg set interfaces ethernet eth0 dhcpv6-pd pd 0 interface switch0 host-address ::1
$cfg set interfaces ethernet eth0 dhcpv6-pd pd 0 interface switch0 service slaac
$cfg set service dns forwarding name-server 2606:4700:4700::1111
$cfg set service dns forwarding name-server 2606:4700:4700::1001

echo Committing Changes, please run save and exit then reboot
$cfg commit
