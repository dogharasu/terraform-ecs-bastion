############################################################################
# Route-table
############################################################################
resource "aws_route_table" "route_pub" {
    route            = [
        {
            carrier_gateway_id         = ""
            cidr_block                 = "0.0.0.0/0"
            destination_prefix_list_id = ""
            egress_only_gateway_id     = ""
            gateway_id                 = aws_internet_gateway.igw.id
            instance_id                = ""
            ipv6_cidr_block            = ""
            local_gateway_id           = ""
            nat_gateway_id             = ""
            network_interface_id       = ""
            transit_gateway_id         = ""
            vpc_endpoint_id            = ""
            vpc_peering_connection_id  = ""
        },
    ]
    tags             = {
        "Name" = "dev-routetable-public"
    }
    vpc_id           = aws_vpc.vpc.id
}

resource "aws_route_table" "route_pri" {
    route            = []
    tags             = {
        "Name" = "dev-routetable-private"
    }
    vpc_id           = aws_vpc.vpc.id
}

############################################################################
# Route-table-association
############################################################################
resource "aws_route_table_association" "route_table_association_pub_a" {
  subnet_id      = aws_subnet.subet_pub_a.id
  route_table_id = aws_route_table.route_pub.id
}

resource "aws_route_table_association" "route_table_association_pri_a" {
  subnet_id      = aws_subnet.subet_pri_a.id
  route_table_id = aws_route_table.route_pri.id
}

resource "aws_route_table_association" "route_table_association_pri_c" {
  subnet_id      = aws_subnet.subet_pri_c.id
  route_table_id = aws_route_table.route_pri.id
}
