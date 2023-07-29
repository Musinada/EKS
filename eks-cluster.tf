
provider "aws" {
  region = var.region
}

module "eks" {
    source            = "terraform-aws-modules/eks/aws"
    version           = "17.18.0"
    cluster_name      = "Anil-EKS-Cluster"
    cluster_version   = "1.23"
    
    cluster_endpoint_public_access  = true

    subnets           = aws_subnet.EKS-public-1.id

    tags = {
        Name = "Anil-EKS-Cluster"
    }

    vpc_id = var.vpc
    
    workers_group_defaults = {
        root_volume_type = "gp2"
    }

    worker_groups = [
        {
            name                            = "Worker-Group-1"
            instance_type                   = var.instance_type
            additional_userdata             = "worker-1"
            associate_public_ip_address     = true
            key_name                        = "anil"
            asg_desired_capacity            = 1
            subnets                         = aws_subnet.EKS-public-2.id
            additional_security_group_ids   = [aws_security_group.worker_group_mgmt_one.id]
            platform                        = "linux"
            tags = {
                Name = "worker-node-1"
                }
        },

        {
            name                            = "Worker-Group-2"
            instance_type                   = var.instance_type
            additional_userdata             = "worker-2"
            associate_public_ip_address     = true
            key_name                        = "anil"
            asg_desired_capacity            = 1
            subnets                         = aws_subnet.EKS-public-3.id
            additional_security_group_ids   = [aws_security_group.worker_group_mgmt_two.id]
            platform                        = "linux"
            tags = {
                Name = "worker-node-2"
                }
        },
    ]
}

resource "aws_key_pair" "anil" {
 key_name = "anil"
 public_key = "${var.anil}"
}

data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_id
}



# For EKS Cluster creation, I have used Terraform AWS EKS Module.
# This will create 2 worker groups (worker_group_one & worker_group_two) with the desired capacity of 3 instances of type t2.medium.
