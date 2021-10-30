#!/bin/bash


cat <<EOF > /$HOME/redis.conf
bind 127.0.0.1
protected-mode yes
port 6379
tcp-backlog 511
timeout 0
tcp-keepalive 300
EOF

