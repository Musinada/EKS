resource "aws_security_group" "worker_group_mgmt_one" {
    name_prefix = "worker_group_mgmt_one"
    vpc_id = var.vpc

ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"

cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
}

resource "aws_security_group" "worker_group_mgmt_two" {
    name_prefix = "worker_group_mgmt_two"
    vpc_id = var.vpc

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"

cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
}

resource "aws_security_group" "all_worker_mgmt" {
    name_prefix = "all_worker_management"
    vpc_id = var.vpc

ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"

cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
}

