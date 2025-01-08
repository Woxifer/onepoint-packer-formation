#!/bin/bash -eu

set -x

packer init aws-ebs.pkr.hcl
packer validate aws-ebs.pkr.hcl
packer build aws-ebs.pkr.hcl | tee packer_output.txt
ami_id=$(< packer_output.txt tail | awk '$1=="eu-west-1:"{print $2}')

terraform -chdir=terraform init
terraform -chdir=terraform validate
terraform -chdir=terraform apply -var="ami_id=$ami_id" -auto-approve
ip_address=$(terraform output -json | jq -r '.public_ip.value')



curl -fsS -m 30 --retry 12 --retry-all-errors "http://$ip_address/"


terraform -chdir=terraform destroy -var="test" -auto-approve
