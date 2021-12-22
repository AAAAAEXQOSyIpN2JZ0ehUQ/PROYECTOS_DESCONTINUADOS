#! /bin/sh
read -p "type in internal interface: " inif
read -p "type in external interface: " exif
read -p "type in socks port: " sport
echo "ok.. please wait a few minute!"
sleep 3
sudo apt-get update -y
sudo apt-get install wget -y
sudo apt-get install curl -y
sudo apt-get install build-essential -y
sudo wget http://www.inet.no/dante/files/dante-1.3.2.tar.gz
sudo gunzip dante-1.3.2.tar.gz
sudo tar -xf dante-1.3.2.tar
cd dante-1.3.2/
sudo ./configure
sudo make
sudo make install
sudo bash -c "cat <<EOF > /etc/danted.conf
logoutput: syslog
internal: $inif port = $sport
external: $exif
external.rotation: same-same
method: username none
user.privileged: proxy
user.notprivileged: nobody
client pass {
        from: 0.0.0.0/0 port 1-65535 to: 0.0.0.0/0
}
client block {
        from: 0.0.0.0/0 to: 0.0.0.0/0
}
pass {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        protocol: tcp udp
}
block {
        from: 0.0.0.0/0 to: 0.0.0.0/0
}
EOF"
sudo bash -c 'cat <<EOF > /etc/sockd.sh
#! /bin/sh
sudo /usr/local/sbin/sockd -D -N 2 -f /etc/danted.conf
EOF'
sudo chmod +x /etc/sockd.sh
sudo crontab -l | { cat; echo '@reboot /etc/sockd.sh'; } | crontab -
sudo /usr/local/sbin/sockd -D -N 2 -f /etc/danted.conf
IP=$(curl http://dantesocks5.appspot.com/ip?port=$sport)
tail /var/log/syslog
echo "your socks5 is: $IP"