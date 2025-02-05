# variable "nullvar" {
#     default=""
# }

# resource "null_resource" "step_1" {
#     provisioner "local-exec" {
#         command = <<EOT
#         if [ -z "${var.nullvar}" ]; then
#             echo "ERROR: Public IP address was not assigned." >&2
#             exit 1
#         fi
#         EOT
#     }

#     depends_on = [aws_instance.vm]
# }