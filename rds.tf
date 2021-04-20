# security groups
resource "aws_security_group" "rds-app" {
  vpc_id = module.vpc.default_vpc_id
  name = "rds-app"
  description = "Allow inbound postgre traffic"
  tags = {
    Name = "rds-app"
  }
}

# sec group
resource "aws_security_group" "app-prod" {
  vpc_id = module.vpc.default_vpc_id
  name = "app-prod"
  description = "App prod security group"

  tags = {
    Name = "app-prod"
  }
}

resource "aws_security_group_rule" "allow-postgres" {
    type = "ingress"
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_group_id = "${aws_security_group.rds-app.id}"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow-outgoing" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.rds-app.id}"
    cidr_blocks = ["0.0.0.0/0"]
}

# rds
resource "aws_db_instance" "rds-app" {
  allocated_storage    = 10
  max_allocated_storage = 30
  engine               = "postgres"
  engine_version       = "12.5"
  instance_class       = "db.m5.large"
  identifier           = "app"
  name                 = "mydb"
  username             = "root"
  password             = "postgreROOTPASSHERE"
  db_subnet_group_name = "${aws_db_subnet_group.rds-app.name}"
  parameter_group_name = "default.postgres12"
  multi_az             = true
  vpc_security_group_ids = ["${aws_security_group.rds-app.id}"]
  storage_type         = "gp2"
  publicly_accessible  = true
  skip_final_snapshot  = "true"

  backup_retention_period = 30
  tags = {
      Name = "rds-app"
  }
}

resource "aws_db_subnet_group" "rds-app" {
    name = "rds-app"
    description = "RDS subnet group"
    subnet_ids = module.vpc.public_subnets
}
