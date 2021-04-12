#!/bin/bash
envsubst < dynuiuc-template.conf > /etc/dynuiuc/dynuiuc.conf
dynuiuc --conf_file /etc/dynuiuc/dynuiuc.conf --log_file /var/log/dynuiuc.log --pid_file /var/run/dynuiuc.pid
