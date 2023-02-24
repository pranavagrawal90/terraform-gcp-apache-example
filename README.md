Terraform module to provision vm instance that is running Apache.

Not intended for production use. Just showcasing how to create a custom module in Terraform Registry.

```hcl
terraform {
	
}

provider "google" {
  project = <PROJECT_NAME>
	region = "us-central1"
}


module "apache2" {
	source = "./terraform-gcp-apache-example"
	vpc_name = "VPC_NAME"
	instance_type = "INSTANCE_TYPE"
	my_ip = "MY_OWN_IP_ADDRESS/32"
}

output "public_ip" {
  value = module.apache2.public_ip
}
```