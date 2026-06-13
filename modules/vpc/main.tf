resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "vpc-${var.project_name}-${var.env}"
    }
    
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone =  var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}-${var.project_name}"
    Env = var.env
  }
}

resource "aws_subnet" "private"{
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]


    tags = {
        Name = "private-subnet-${count.index + 1}-${var.project_name}"
        Env = var.env
    }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${var.project_name}-${var.env}"
  }
}


resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat-eip-${var.project_name}-${var.env}"
  }

  depends_on = [ aws_internet_gateway.main ]
}

resource "aws_nat_gateway" "main"{
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public[0].id

    tags = {
      name = "nat-gateway-${var.project_name}-${var.env}"
    }

    depends_on = [ aws_internet_gateway.main ]

}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
    
    tags = {
        Name = "public-rt-${var.project_name}"
        Env = var.env
    }
}

resource "aws_route_table_association" "public"{
    count = length(aws_subnet.public)
    route_table_id = aws_route_table.public.id
    subnet_id = aws_subnet.public[count.index].id
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.main.id
    }

    tags = {
      Name = "private-rt-${var.project_name}-${var.env}"
    }
  
}

resource "aws_route_table_association" "private" {
    count = length(aws_subnet.private)
    route_table_id = aws_route_table.private.id
    subnet_id = aws_subnet.private[count.index].id
  
}