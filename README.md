# iac-tuanpham
Just a practical test from Eric

## How to use this repo
### Terraform
  - Require Terraform v0.12.21
  - Ask @brian for credentials.json for terraform running

**Step:**
  - cd terraform/main
  - terraform init
  - terraform plan
  - terraform apply

**Sample Result**

  - Create VPC:
```
gcloud compute networks list --project=tundo-0612
NAME                     SUBNET_MODE  BGP_ROUTING_MODE  IPV4_RANGE  GATEWAY_IPV4
test-vpc                 CUSTOM       GLOBAL
```

  - Create subnet
```
gcloud compute networks subnets list --project=tundo-0612
NAME          REGION                   NETWORK   RANGE
test-private  asia-east1               test-vpc  10.10.1.0/24
test-public   asia-east1               test-vpc  10.10.2.0/24
```

  - Create some VM instances:
```
gcloud compute instances list --project=tundo-0612
NAME        ZONE          MACHINE_TYPE  PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP    STATUS
management  asia-east1-a  f1-micro      true         10.10.2.5    35.234.57.115  TERMINATED
app-01      asia-east1-b  f1-micro      true         10.10.1.9                   RUNNING
app-02      asia-east1-c  f1-micro      true         10.10.1.8                   RUNNING
```

  - Some firewall:
```
gcloud compute firewall-rules list --project=tundo-0612
NAME                      NETWORK   DIRECTION  PRIORITY  ALLOW                         DENY  DISABLED
allow-ssh-from-office     test-vpc  INGRESS    1000      icmp,tcp:22                         False
management-access-app     test-vpc  INGRESS    1000      tcp:80,tcp:443,tcp:22               False
management-public-access  test-vpc  INGRESS    1000      tcp:80,tcp:443                      False
```


### Ansible
  - Require ansible version 2.x
  - *The creator also project owner, so he's already have osAdminLogin priviledge.*

**Step:**
  - SSH to managemenent node with option *ForwardAgent*
```
gcloud compute ssh --project=tundo-0612 management
No zone specified. Using zone [asia-east1-a] for instance: [management].
Warning: Permanently added 'compute.8148475169451364196' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 5.0.0-1033-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri Apr 10 22:23:58 UTC 2020

  System load:  0.83              Processes:           95
  Usage of /:   14.1% of 9.52GB   Users logged in:     0
  Memory usage: 39%               IP address for ens4: 10.10.2.5
  Swap usage:   0%

39 packages can be updated.
23 updates are security updates.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

tuanpham@management:~$
```

  - From management server, install git and pull this repo, install ansible 2.x
  - cd ansible
  - Check the connection with command           `ansible -i inventory private-app -m ping all`
  - ```ansible-playbook -i inventory playbooks/playbook.yml```