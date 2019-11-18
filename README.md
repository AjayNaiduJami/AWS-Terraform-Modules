Terraform AWS Individual Modules
=================================
## These terraform modules provide basic infrastructure in [AWS](https://aws.amazon.com) environment.
---------------------------------
## VPC (Virtual Private Cloud)
#### "VPC enables you to launch AWS resources into a virtual network"

### VPC
- Creation of VPC
- Enable DNS hostnames
- Enable DNS support
### Subnet
- Creation of public and private subnets
- Creation of public and private subnet route table
- Assocation of subnets to route tables
### Internet Gateway
- Creation of internet gateway
- Association of internet gateway with vpc
### NAT Gateway
- Creation of Elastic IPs
- Creation of NAT gateways
- Allocation of Elastic IPs to NAT Gateways
- Association of NAT Gateways with public subnets
### Security Groups
- Creation of security groups
- Creation of security group rules with CIDR block as input
- Creation of security group rules with security group IDs as input
- Association of security group rules with security groups
---------------------------------------------------------------------
## EC2 (Elastic Cloud Compute)
#### "EC2 provides scalable computing capacity in the Amazon Web Services (AWS) cloud"

### Instances
- Creation of Instances
- Specification of root volume details
- Attachment of additional volume to instance
- Associating VPC and subnet in which instance need to be created
- Adding user data file to execute at initial launch of instance/server
- Associationg key file to access server via SSH
- Associating security group in which this instance need to be under
### Amazon Cerificate Manager
- Importing of certificates from local to ACM
### Elastic Load Balancers
- Creation of Elastic Load Balancer
- Assigning of multiple subnets to ELB
- Assigning of security groups
- Associating instances for load balancing
- Configuration of listener ports and protocols
- Assigning health check parameters
### Network Load Balancers
- Specification of Load Balancer type
- Specification of Load Balancer usage
- Creation of Load Balancer
- Assigning of multiple subnets to NLB
- Assigning of multiple security groups to ALB
### Target Groups
- Creation of Target Group
- Specify the target type, instance ID or ip
- Specify the port on which targets receive traffic, Required when target_type is instance or ip
- Specify the protocol to use for routing traffic to the targets, Required when target_type is instance or ip
- Associating VPC
- Configuring health check parameters
### Load Balancer Listeners
- Creation of Load Balancer Listener with port 80 and and forwarding to a Target Group
- Creation of Load Balancer Listener with port 443, asssociatig a SSL certificate from AMC and forwarding to a Target Group
- Association of created Listerners to Load Balancers
### Launch Configurations
- Creation of a Launch Configuration template
- Specify the AMI ID
- Specify instance type
- Adding user data file to execute at initial launch of instance/server
- Associating key file to access server via SSH
- Associating security group in which this instances need to be under
### Autoscaling Groups
- Creation of Autoscaling Group
- Association of launch configuration template
- Specify desired capacity of servers need to be available
- Association of availability zones or association of subnets to specify availability zones
- Specify maximum size of scaling capacity
- Specify minimum size of scaling capacity
- Association of load balancer with autoscaling group (only in Classic load balancer [ELB])
- Association of load balancer with Target Groups (only in Classic load balancer [NLB/ALB])


**NOTE**: Using the resource `tags` functionality we can audit, track and manage resources.

##### The outputs displayed after Terraform Apply can be exported to a `.json` format by using command: 
```bash
terraform output -json > output_values.json
```
##### Or to a text file in standard format using command:
```bash
terraform output > output_values.txt
```

Authors
=======

**Originally created and maintained by [Ajay Naidu Jami](https://github.com/AjayNaiduJami)**
