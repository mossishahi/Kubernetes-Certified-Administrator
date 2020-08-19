#!/bin/bash

IP=$1

cat <<EOF >ceph.conf
[global]
osd crush chooseleaf type = 0
EOF

cephadm bootstrap \
  --mon-ip $IP \
  --initial-dashboard-user admin \
  --initial-dashboard-password password \
  --config ceph.conf

ceph orch daemon add osd ceph-mon-01:/dev/sdb
ceph orch daemon add osd ceph-mon-01:/dev/sdc
ceph orch daemon add osd ceph-mon-01:/dev/sdd

ceph osd pool create cka 32

exit 0
