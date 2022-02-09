############################################################################
# Security-group
############################################################################
resource "aws_security_group" "sg_pub" {
    description = "dev-sg-public"
    egress      = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
        },
    ]
    ingress     = []
    name        = "dev-sg-public"
    tags        = {
        "Name" = "dev-sg-public"
    }
    vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group" "sg_pri" {
    description = "dev-sg-private"
    egress      = []
    ingress     = [
        {
            cidr_blocks      = [
                "10.0.0.0/16",
            ]
            description      = ""
            from_port        = 3306
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 3306
        },
    ]
    name        = "dev-sg-private"
    tags        = {
        "Name" = "dev-sg-private"
    }
    vpc_id      = aws_vpc.vpc.id
}