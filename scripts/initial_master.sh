#!/bin/bash

set -e

# 导入镜像
. ./loadimage.sh


if [ ${#POD_SUBNET} -eq 0 ] || [ ${#APISERVER_NAME} -eq 0 ]; then
  echo -e "\033[31;1m请确保您已经设置了环境变量 POD_SUBNET 和 APISERVER_NAME \033[0m"
  echo 当前POD_SUBNET=$POD_SUBNET
  echo 当前APISERVER_NAME=$APISERVER_NAME
  exit 1
fi

echo "${MASTER_IP}    ${APISERVER_NAME}" >> /etc/hosts

# 查看完整配置选项 https://godoc.org/k8s.io/kubernetes/cmd/kubeadm/app/apis/kubeadm/v1beta2
rm -f ./kubeadm-config.yaml
cat <<EOF > ./kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
kubernetesVersion: v1.17.1
controlPlaneEndpoint: "${APISERVER_NAME}:6443"
networking:
  serviceSubnet: "10.96.0.0/16"
  podSubnet: "${POD_SUBNET}"
  dnsDomain: "cluster.local"
EOF

# kubeadm init
# 根据您服务器网速的情况，您需要等候 3 - 10 分钟
kubeadm init --config=kubeadm-config.yaml --upload-certs

# 配置 kubectl
rm -rf /root/.kube/
mkdir /root/.kube/
cp -i /etc/kubernetes/admin.conf /root/.kube/config

# 安装 calico 网络插件
# 参考文档 https://docs.projectcalico.org/v3.10/getting-started/kubernetes/
echo "安装calico-3.10.3"
rm -f calico.yaml
cp ../plugins/calico-v3.10.3.yaml ./calico.yaml
sed -i "s#192\.168\.0\.0/16#${POD_SUBNET}#" calico.yaml
kubectl apply -f calico.yaml

# 安装 nginx ingress controll
echo "安装nginx ingress controll"
kubectl apply -f ../plugins/ingress-nginx-v0.29.0.yaml

# 安装 Dashboard
echo "安装 Dashboard"
kubectl apply -f ../plugins/dashboard-auth.yaml
kubectl apply -f ../plugins/dashboard-v2.0.0-rc5.yaml

# 安装 Kuboard
echo "安装 Kuboard"
kubectl apply -f ../plugins/kuboard.yaml
kubectl apply -f ../plugins/metrics-server-v0.3.6.yaml
