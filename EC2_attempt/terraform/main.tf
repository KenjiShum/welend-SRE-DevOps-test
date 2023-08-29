resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Ubuntu's AMI owner ID
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow inbound HTTP and SSH traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDiXg9DaztQOs5kY0whye7rAi+/eyzQlmET/eqlx4OU721Kn27ZnN40GVixiHHxHJtFarRikuNiO3UDnIvYzVW8GpqvqCLx9iiWZyy7LBtObV6oecer87qir3hjatLuvJ9rMvpJ5t6rY3eYP/LFnF1qZ7COushSmKv7Im1ZlZOJV1+TPrpJMWaIjDDJ8vnI+DIZAnB4obwIfV8H/o7hURUn9OKJkcOt5DDpGE7up/QNkVHMXacfdJQL1FNjZiqFpQhrbd9gfg8De3tpW0lk2pMuKpMIw+/vfwMJc+2Lx498ywamxGi1qhgkmjNEH/PHJN8JmZ5ONPmOiL1QND4UHaehgadWA3G1MgCGBZp03LKReqOJ3AQJpW89Z97aOJdMpCb0y3YO3u1PzHIPTg+fSGrLtL55v092Gfxa57NkbAt8bgpyOa9R8mx0inNMFifEehJBeLz5MM3M70KD9ekFYvZEv84imc82kh5CzW8oOLBV1yJ9uh8G44w86X7vWwonfXc= kenjishum@Kings-MacBook-Pro.local"
}

resource "aws_instance" "nginx" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  key_name      = "ssh-key"

  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tags = {
    Name = "nginx"
  }
}

