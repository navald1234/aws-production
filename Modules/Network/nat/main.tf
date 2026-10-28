resource "aws_eip" "nat_eip" {

  count = length(var.public_subnet_ids)

  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-nat-eip-${count.index + 1}"
    }
  )
}

resource "aws_nat_gateway" "nat" {

  count = length(var.public_subnet_ids)

  allocation_id = aws_eip.nat_eip[count.index].id

  subnet_id = var.public_subnet_ids[count.index]

  

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-nat-${count.index + 1}"
    }
  )
}