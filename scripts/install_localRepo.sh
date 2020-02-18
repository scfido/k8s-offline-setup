#!/bin/bash

rpm -ivh ../packages/deltarpm-3.6-3.el7.x86_64.rpm
rpm -ivh ../packages/libxml2-python-2.9.1-6.el7_2.3.x86_64.rpm
rpm -ivh ../packages/python-deltarpm-3.6-3.el7.x86_64.rpm
rpm -ivh ../packages/createrepo-0.9.9-28.el7.noarch.rpm

createrepo  /root/k8sOfflineSetup/packages

# 备份现有源
if [ -f "/etc/yum.repos.d/CentOS-Base.repo" ];then
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo_bak_$(date "+%Y-%m-%d_%H-%M-%S")
fi
cp -f ../repos/CentOS-Media.repo /etc/yum.repos.d/
