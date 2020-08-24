resource "aws_route53_zone" "primary" {
  name = "druid.life"
}
//
resource "aws_route53_record" "main" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "druid.life"
  type    = "A"

  alias {
    evaluate_target_health = false
    name = aws_lb.this.dns_name
    zone_id = aws_lb.this.zone_id
  }
}