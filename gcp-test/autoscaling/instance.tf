#####################################################################
# Networking
#####################################################################

resource "google_compute_network" "default" {
  name = "ecom"
}

resource "google_compute_subnetwork" "subnet-1" {
  name = "subnet-1"
  // http://www.aboutmyip.com/AboutMyXApp/SubnetCalculator.jsp?ipAddress=10.0.0.0&cidr=20
  // Possible 4094 devices
  // First host: 10.0.0.1
  // Last host:  10.0.15.254
  ip_cidr_range = "10.0.0.0/21"
  network = "${google_compute_network.default.name}"
  //network = "default"
  region = "${var.region}"
}


#####################################################################
# VM Instances
#####################################################################

resource  "google_compute_instance" "webserver" {
    
    name    = "webserver"
    machine_type  = "${var.machine_type}"
    zone  = "${var.region_zone}"
    
    boot_disk {
      initialize_params {
        image = "${var.disk_image_ubuntu}"
        type = "pd-standard"  // pd-ssd
        size = "10"
      }
      
      auto_delete = "true" // Whether the disk will be auto-deleted when the instance is deleted    
    }

    metadata  {
        ssh-keys  = "${var.ssh_username}:${file("${var.ssh_key}.pub")}"
    }

    tags  = ["http-server", "https-server"]

    network_interface {
      subnetwork = "${google_compute_subnetwork.subnet-1.self_link}"

      access_config {
        // Ephemeral IP : The Ip address will be available until the instance is alive, 
        // when the stack is destroy and apply again, the public Ip is a new one
      }
    }

    provisioner "remote-exec" {
        connection  {
            type = "ssh"
            user        = "${var.ssh_username}"
            private_key = "${file("${var.ssh_key}")}"
        }

        inline  = [
            "sudo apt-get update",
            "sudo apt-get install -y apache2",
            "sudo service apache2 start",
            "sudo a2ensite default-ssl",
            "sudo a2enmod ssl",
            "sudo service apache2 restart",
            "sudo update-rc.d apache2 enable"
        ]
    }
}


#####################################################################
# Firewall rules
#####################################################################

# resource "google_compute_firewall" "default-allow-ssh" {
#   name = "default-allow-ssh"
#   network = "${google_compute_network.default.name}"

#   allow {
#     protocol = "tcp"
#     ports = ["22"]
#   }

#   source_ranges = [
#     "0.0.0.0/0"
#     // = everything @todo
#   ]
# }

# resource "google_compute_firewall" "default-allow-icmp" {
#   name = "default-allow-icmp"
#   network = "default"

#   allow {
#     protocol = "icmp"
#   }

#   source_ranges = [
#     "0.0.0.0/0"
#     // = everything @todo
#   ]
# }

resource "google_compute_firewall" "default-allow-http" {
  name = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "80"
    ]
  }

  target_tags = ["http-server"]

  source_ranges = [
    "0.0.0.0/0"
    // = everything @todo
  ]
}

resource "google_compute_firewall" "default-allow-https" {
  name = "default-allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["443"]
  }

  target_tags = ["https-server"]

  source_ranges = [
    "0.0.0.0/0"
    // = everything @todo
  ]
}