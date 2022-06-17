#Create VPC
resource "aws_vpc" "main" {
  cidr_block       = "172.16.0.0/24"

  tags = {
    Name = "first-lesson"
  }
}

#Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "first-lesson"
  }
}

#Get all available AZ's in the VPC
data "aws_availability_zones" "azs" {
  state = "available"
}

#create public subnet #1
resource "aws_subnet" "public_subnet_1" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id     = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block = "172.16.0.0/26"

  tags = {
    Name = "first-lesson-public-1"
  }
}

#create public subnet #2
resource "aws_subnet" "public_subnet_2" {
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id     = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block = "172.16.0.64/26"

  tags = {
    Name = "first-lesson-public-2"
  }
}

#create private subnet #1
resource "aws_subnet" "private_subnet_1" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.16.0.128/26"

  tags = {
    Name = "first-lesson-private-1"
  }
}

#create private subnet #2
resource "aws_subnet" "private_subnet_2" {
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.16.0.192/26"

  tags = {
    Name = "first-lesson-public-2"
  }
}

#create route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }

  tags = {
    Name = "first-lesson-public-route-table"
  }
}

resource "aws_route_table_association" "assoc-public-1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "assoc-public-2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}