[root@node01 ~]# iptables -nL
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         
KUBE-NODEPORT-NON-LOCAL  all  --  0.0.0.0/0            0.0.0.0/0            /* Ensure that non-local NodePort traffic can flow */
KUBE-FIREWALL  all  --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0            /* traffic from docker */
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0            /* traffic from SDN */
ACCEPT     udp  --  0.0.0.0/0            0.0.0.0/0            multiport dports 4789 /* 001 vxlan incoming */
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
ACCEPT     icmp --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:22
OS_FIREWALL_ALLOW  all  --  0.0.0.0/0            0.0.0.0/0           
REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         
DOCKER-ISOLATION  all  --  0.0.0.0/0            0.0.0.0/0           
DOCKER     all  --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0            ctstate RELATED,ESTABLISHED
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     all  --  10.128.0.0/14        0.0.0.0/0           
ACCEPT     all  --  0.0.0.0/0            10.128.0.0/14       
REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
KUBE-SERVICES  all  --  0.0.0.0/0            0.0.0.0/0            /* kubernetes service portals */
KUBE-FIREWALL  all  --  0.0.0.0/0            0.0.0.0/0           

Chain DOCKER (1 references)
target     prot opt source               destination         

Chain DOCKER-ISOLATION (1 references)
target     prot opt source               destination         
RETURN     all  --  0.0.0.0/0            0.0.0.0/0           

Chain KUBE-FIREWALL (2 references)
target     prot opt source               destination         
DROP       all  --  0.0.0.0/0            0.0.0.0/0            /* kubernetes firewall for dropping marked packets */ mark match 0x8000/0x8000

Chain KUBE-NODEPORT-NON-LOCAL (1 references)
target     prot opt source               destination         

Chain KUBE-SERVICES (1 references)
target     prot opt source               destination         

Chain OS_FIREWALL_ALLOW (1 references)
target     prot opt source               destination         
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:10250
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:80
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:443
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:10255
ACCEPT     udp  --  0.0.0.0/0            0.0.0.0/0            state NEW udp dpt:10255
ACCEPT     udp  --  0.0.0.0/0            0.0.0.0/0            state NEW udp dpt:4789
[root@node01 ~]# 
