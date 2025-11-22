apply:
	cd infrastructure && terraform apply --auto-approve -var-file=env.tfvars

destroy:
	cd infrastructure && terraform destroy --auto-approve -var-file=env.tfvars