resource "aws_subnet" "public" {

  count = length(var.public_subnets)

  vpc_id = var.vpc_id

  cidr_block = var.public_subnets[count.index]

  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-public-subnet-${count.index + 1}"

      "kubernetes.io/role/elb" = "1"

      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}

resource "aws_subnet" "private" {

  count = length(var.private_subnets)

  vpc_id = var.vpc_id

  cidr_block = var.private_subnets[count.index]

  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-private-subnet-${count.index + 1}"

      "kubernetes.io/role/internal-elb" = "1"

      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}