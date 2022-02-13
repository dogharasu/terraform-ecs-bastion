############################################################################
# Subnet
############################################################################
resource "aws_subnet" "subet_pub_a" {

  availability_zone = "ap-northeast-1a"

  cidr_block = "10.0.0.0/24"
  tags = {
    "Name" = "dev-subnet-public-a"
  }
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "subet_pri_a" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    "Name" = "dev-subnet-private-a"
  }
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "subet_pri_c" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.2.0/24"
  tags = {
    "Name" = "dev-subnet-private-c"
  }
  vpc_id = aws_vpc.vpc.id
}
