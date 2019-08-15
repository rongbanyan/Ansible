#!/bin/bash
pwd=$(grep 'temporary password' /data/mysql/error.log | awk '{print $NF}')
newpwd=123456
mysql -uroot -p"$pwd" --socket=/data/mysql/mysql.sock --connect-expired-password <<EOF
alter user 'root'@'localhost' identified by '$newpwd';
grant all privileges on *.* to 'root'@'%' identified by '$newpwd' with grant option;
grant all privileges on *.* to 'mykjdba'@'%' identified by '$newpwd' with grant option;
flush privileges;
EOF
