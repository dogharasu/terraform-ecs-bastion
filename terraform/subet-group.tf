############################################################################
# Subnet-group
############################################################################
resource "aws_db_subnet_group" "subnet_group" {
    name        = "dev-subnetgroup"
    description = "dev-subnetgroup"
    subnet_ids  = [
        aws_subnet.subet_pri_a.id,
        aws_subnet.subet_pri_c.id,
    ]
}