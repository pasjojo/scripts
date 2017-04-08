#!/bin/bash
echo "hosts"
echo "-----------------------"
cp /usr/local/scripts/hosts /etc/

echo "Transport https et depots"
echo "-----------------------"
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

echo "Update... Upgrade et dist-upgrade"
echo "-----------------------"
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

echo "Installation de docker et de kubernetes"
echo "-----------------------"
apt-get install -y docker.io
apt-get install -y kubelet kubeadm kubectl kubernetes-cni

echo "gluster-fs modules"
echo "-----------------------"
modprobe dm_thin_pool
echo dm_thin_pool >> /etc/modules-load.d/modules.conf

echo "gluster-fs-client et python"
echo "-----------------------"
apt-get install glusterfs-client python -y


echo "NTP"
apt-get install ntpdate
ntpdate-debian
echo "11 */6  * * *   root    /usr/sbin/ntpdate-debian" >> /etc/crontab 

echo "Clean up"
echo "-----------------------"
apt-get autoremove -y
