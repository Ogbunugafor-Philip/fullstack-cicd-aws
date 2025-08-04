output "s3_bucket_name" {
  description = "Name of the frontend S3 bucket"
  value       = aws_s3_bucket.frontend_bucket.bucket
}

output "s3_website_url" {
  description = "Public URL to access the frontend website"
  value       = aws_s3_bucket_website_configuration.frontend_bucket_website.website_endpoint
}

output "cloudfront_url" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.frontend_distribution.domain_name
}

output "ecr_backend_repo_url" {
  description = "Backend ECR repository URL"
  value       = aws_ecr_repository.backend_repo.repository_url
}

output "ecr_frontend_repo_url" {
  description = "Frontend ECR repository URL"
  value       = aws_ecr_repository.frontend_repo.repository_url
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.backend_instance.public_ip
}
