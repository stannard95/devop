provider "aws" {
	region = "eu-west-2"
}

# app security group
resource "aws_security_group" "elb" {
  name = "elb"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = "${aws_vpc.uat.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = ["${aws_subnet.private-app.cidr_block}"]
  }
  tags {
    Name = "elb-keir"
  }
}

# app security group
resource "aws_security_group" "app" {
  name = "app"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = "${aws_vpc.uat.id}"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.public-elb.cidr_block}"]
  }

  # ingress {
  #   from_port = 443
  #   to_port = 443
  #   protocol = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = ["${aws_subnet.private-db.cidr_block}"]
  }
  tags {
    Name = "app-keir"
  }
}

# db security group
resource "aws_security_group" "db" {
  name = "db"
  description = "Allow traffic from app"
  vpc_id      = "${aws_vpc.uat.id}"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.private-app.cidr_block}"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.private-app.cidr_block}"]
  }
  tags {
    Name = "db-keir"
  }
}

# public network acl
resource "aws_network_acl" "public-elb-keir" {
  vpc_id = "${aws_vpc.uat.id}"
  subnet_ids = ["${aws_subnet.public-elb.id}"]
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${aws_subnet.private-app.cidr_block}"
    from_port  = 0
    to_port    = 65535
  }
 
  tags {
    Name = "public-keir"
  }
}

# private network acl
resource "aws_network_acl" "private-app-keir" {
  vpc_id = "${aws_vpc.uat.id}"
  subnet_ids = ["${aws_subnet.private-app.id}"]
 ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "${aws_subnet.public-elb.cidr_block}"
    from_port  = 3000
    to_port    = 3000
  }
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "${aws_subnet.public-elb.cidr_block}"
    from_port  = 0
    to_port    = 65535
  }
  tags {
    Name = "private-app-keir"
  }
}

# private network acl
resource "aws_network_acl" "private-db-keir" {
  vpc_id = "${aws_vpc.uat.id}"
  subnet_ids = ["${aws_subnet.private-db.id}"]
 ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "${aws_subnet.private-app.cidr_block}"
    from_port  = 27017
    to_port    = 27017
  }
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "${aws_subnet.private-app.cidr_block}"
    from_port  = 0
    to_port    = 65535
  }
  tags {
    Name = "private-db-keir"
  }
}

# private network acl
resource "aws_network_acl" "default-keir" {
  vpc_id = "${aws_vpc.uat.id}"
  ingress {
     protocol   = -1
    rule_no    = 99
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 99
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "private-keir"
  }
}

# internet gateway
resource "aws_internet_gateway" "keir-gateway" {
  vpc_id = "${aws_vpc.uat.id}"

  tags {
    Name = "keir-gw"
  }
}

# app route table
resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.uat.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.keir-gateway.id}"
  }

  tags {
    Name = "keir-route-public"
  }
}

# app subnet && route table assoication
resource "aws_route_table_association" "public-keir" {
  subnet_id      = "${aws_subnet.public-elb.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

# db route table
resource "aws_route_table" "private-rt" {
  vpc_id = "${aws_vpc.uat.id}"

  tags {
    Name = "keir-route-private"
  }
}

# db subnet && route table assoication
resource "aws_route_table_association" "private-keir" {
  subnet_id      = "${aws_subnet.private-db.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
}

# vpc
resource "aws_vpc" "uat" {
  cidr_block = "10.6.0.0/16"
  tags {
    Name = "main-keir"
  }
}

data "template_file" "init" {
  template = "${file("templates/init.sh.tpl")}"

  vars {
    db_host_ip ="${aws_instance.db.private_ip}"
  }
}

# app subnet
resource "aws_subnet" "public-elb" {
  vpc_id = "${aws_vpc.uat.id}"
  cidr_block = "10.6.2.0/24"
  map_public_ip_on_launch = true
  tags {
    Name = "elb-keir"
  }
  availability_zone = "eu-west-2a"
}

# app subnet
resource "aws_subnet" "private-app" {
  vpc_id = "${aws_vpc.uat.id}"
  cidr_block = "10.6.0.0/24"
  tags {
    Name = "app-keir"
  }
  availability_zone = "eu-west-2a"
}

# db subnet
resource "aws_subnet" "private-db" {
  vpc_id     = "${aws_vpc.uat.id}"
  cidr_block = "10.6.1.0/24"
  tags {
    Name = "db-keir"
  }
  availability_zone = "eu-west-2a"
}

# Create a new load balancer
resource "aws_elb" "keir-elb" {
  name               = "keir-elb"
  availability_zones = ["eu-west-2a"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 8000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = ["${aws_instance.private-app.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "keir-elb"
  }
}

# app instance
resource "aws_instance" "app" {
  ami = "ami-e0dcc084"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.private-app.id}"
  security_groups = ["${aws_security_group.app.id}"]
  user_data = "${data.template_file.init.rendered}"
  tags {
    Name = "app-keir"
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = ["aws_instance.db"]
}

# database instance
resource "aws_instance" "db" {
  ami = "ami-23fae647"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.private-db.id}"
  security_groups = ["${aws_security_group.db.id}"]
  tags {
    Name = "db-keir"
  }
  lifecycle {
    create_before_destroy = true
  }
}