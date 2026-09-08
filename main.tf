resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "sub1" {
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  vpc_id = aws_vpc.myvpc.id
  map_public_ip_on_launch = true
}

resource "aws_subnet" "sub2" {
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  vpc_id = aws_vpc.myvpc.id
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.sub1.id 
  route_table_id =  aws_route_table.RT.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id = aws_subnet.sub2.id 
  route_table_id =  aws_route_table.RT.id
}