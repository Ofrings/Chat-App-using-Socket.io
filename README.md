Making #Step 1

Create a directory for Terraform 
/terraform
terraform Init 
create a file network.tf

set region in us-east-2 (OHIO)
create aws_vpc root named main (OmarVPC)

following the documentation: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build

create the two subnet a and b
add the vpc by the parameter id (aws_vpc.main.id)
set diference cidr_block for a and b to set two different availability zones

terraform apply

Making #Step 2

create a file ec2.tf

create the two EC2 instances ec2_instance_1 and ec2_instance_2 [EC2-1,EC2-2]
add the subnet id [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
add the AMI ID for the instances (ami-0ccabb5f82d4c9af5) 

terraform apply

following the documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_subnet_cidr_reservation


Making #Step 3

create a file load_balancer.tf


create the load balancer for application as omarLB (omar-lb)
add the subnets [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
create the listener for the load balancer omar-lb-listener 
add the the load balanacer to the listener by the parameter the aws_lb.omarLB.arn
add the the protocol HTTP by port 80 because i dont have https certificates

#Important to be connected to internet
create the internet gateway named inter (Internet)
add the vpc by the parameter id (aws_vpc.main.id)
create the public route table public_route_table (PublicTable)
add the internet gateway by the parameter of Inter (aws_internet_gateway.inter.id)
create the route table for a and b [ps-route-table-association-a, ps-route-table-association-b] adding the PublicTable and subnet id 
create the security group named OmarGroup (Security Group)
add to the vpc (aws_vpc.main.id)
add the igress and egress for HTTP
add the security group to the load balancer omarLB by the parameter [aws_security_group.OmarGroup.id]
create the lb target group named target-group (TargetGroupLB)
add the port, protocol and vpc by the parameter id (aws_vpc.main.id) and target_ty to instance
to the omar-lb-listener add the action forward instances and target-group by the parameter (aws_lb_target_group.target-group.id)
create the lb target group attachments for a and b [lb_attach_a,lb_attach_b]
add the target group by the parameter (aws_lb_target_group.target-group.arn)
add the target id for each instance [aws_instance.ec2_instance_1.id,aws_instance.ec2_instance_2.id]


following the documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
following the documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group

terraform plan to see changes
terraform apply

#Step 4
Install Ansible but its not clear how to do the task.
Install node.js 
I can't set up the application with ansible due to time since still learning aws and terraform, maybe with more time i would complete the task


#Step 5 
Use the Readme already created on the project 
add to the gitignore the folders of terraform installation and others for committing to github
