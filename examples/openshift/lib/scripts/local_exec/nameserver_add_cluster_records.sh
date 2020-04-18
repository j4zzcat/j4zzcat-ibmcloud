KEY_FILE=${1}
NETWORK_SERVER_FIP=${2}
CLUSTER_NAME=${3}
DOMAIN_NAME=${4}
HAPROXY_MASTERS_PIP=${5}
HAPROXY_WORKERS_PIP=${6}
MASTER_1_PIP=${7}
MASTER_2_PIP=${8}
MASTER_3_PIP=${9}

FQDN=${CLUSTER_NAME}.${DOMAIN_NAME}

echo -e "\
  host-record=api.${FQDN}.,${HAPROXY_MASTERS_PIP}\n\
  host-record=api-int.${FQDN}.,${HAPROXY_MASTERS_PIP}\n\
  host-record=*.apps.${FQDN}.,${HAPROXY_WORKERS_PIP}\n\
  host-record=etcd-0.${FQDN}.,${MASTER_1_PIP}\n\
  host-record=etcd-1.${FQDN}.,${MASTER_2_PIP}\n\
  host-record=etcd-2.${FQDN}.,${MASTER_3_PIP}\n\
  srv-host=_etcd-server-ssl._tcp.${FQDN}.,etcd-0.${FQDN},2380,0,10\n\
  srv-host=_etcd-server-ssl._tcp.${FQDN}.,etcd-1.${FQDN},2380,0,10\n\
  srv-host=_etcd-server-ssl._tcp.${FQDN}.,etcd-2.${FQDN},2380,0,10\n\
" | ssh \
  -oStrictHostKeyChecking=no \
  -i ${KEY_FILE} \
  root@${NETWORK_SERVER_FIP} \
  "cat >> /etc/dnsmasq.conf"
