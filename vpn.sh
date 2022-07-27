#!/bin/bash
      sudo apt-get update
      sudo apt-get install \
      apt install xdg-utils\
      apt install mailcap\
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common \
      OVPN_DATA="ovpn-data-example" \
      net-tools -y
      sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
      sudo apt-get update
      #####create docker0 bridge
      #fix for https://wiki.archlinux.org/index.php/Talk:Docker#Docker_service_failed_to_start_%22Error_initializing_network_controller:_list_bridge_addresses_failed:_no_available_network%22
      sudo apt-get install bridge-utils
      sudo brctl addbr docker0
      sudo ip addr add 192.168.42.1/24 dev docker0
      sudo ip link set dev docker0 up
      ip addr show docker0
      sudo systemctl restart docker
      sudo iptables -t nat -L -n
      #
      sudo apt-get install docker-ce docker-ce-cli containerd.io net-tools jq -y
      docker run -it --rm --cap-add=NET_ADMIN \
      -p 1194:1194/udp -p 80:8080/tcp \
      -e HOST_ADDR=$(curl -s https://api.ipify.org) \
      --name dockovpn alekslitvinenk/openvpn
      docker rename dockovpn BullShort
