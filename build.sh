packer init aws-ebs.pkr.hcl
packer validate aws-ebs.pkr.hcl
packer build aws-ebs.pkr.hcl

terraform -chdir=terraform init
terraform -chdir=terraform validate
terraform -chdir=terraform apply -var="test" -auto-approve

curl http://1.1.1.1/ | grep foo


terraform -chdir=terraform destroy -var="test" -auto-approve
