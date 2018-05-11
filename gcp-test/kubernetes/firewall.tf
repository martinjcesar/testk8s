#####################################################################
# Firewall rules
#####################################################################

# resource "google_compute_firewall" "allow-icmp-ssh-network-1" {
#   name    = "allow-icmp-ssh-network-1"
#   network = "${google_compute_network.vpn-network-1.name}"

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   allow {
#     protocol = "icmp"
#   }
#   source_ranges = ["0.0.0.0/0"]
# }

# resource "google_compute_firewall" "allow-icmp-ssh-network-2" {
#   name    = "allow-icmp-ssh-network-2"
#   network = "${google_compute_network.vpn-network-2.name}"

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   allow {
#     protocol = "icmp"
#   }
#   source_ranges = ["0.0.0.0/0"]
# }