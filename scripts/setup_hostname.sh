#!bin/bash

if [ ! -n "$1"  ] ; then
  echo -e "\033[31;1mError:请传入hostname \033[0m"
  echo 用法 setup_hostname yourname
  exit 1
fi

# 修改 hostname,
hostnamectl set-hostname ${1}
# 查看修改结果
hostnamectl status

# 设置 hostname 解析，这个命令需要root账户才能执行。
echo "127.0.0.1   $(hostname)" >> /etc/hosts 