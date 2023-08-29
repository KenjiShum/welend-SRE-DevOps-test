output "instance_public_ip" {
  description = "The public IP of the web instance"
  value       = aws_instance.nginx.public_ip
}