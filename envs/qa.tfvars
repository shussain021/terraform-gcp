#project
project_id = "carbon-vault-467216-p3"

#network
vpc_name = "default"
subnet_name = "default"

#bucket
bucket_name = "sheraz-bucket-qa"

#virtual machine
vm_name = "sheraz-vm-qa"
machine_type = "e2-micro"
zone = "us-east1-b"

#sql instance
sql_instance_name = "sheraz-sql-postgres17-qa"
db_type =  "db-f1-micro"
db_username = "adminuser"
secret_name = "adminuser"
db_name = [ "customer-db","payments-db", ]

#fwrule
fw_rule = "postgres-fw"