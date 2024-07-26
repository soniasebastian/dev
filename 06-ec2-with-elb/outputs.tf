output "aws_security_group_elb_sg" {
  value = aws_security_group.elb_sg
}

output "http_server_public_dns" {
  value = values(aws_instance.http_servers).*.id
}


output "elb_public_dns" {
  value = aws_elb.elb
}