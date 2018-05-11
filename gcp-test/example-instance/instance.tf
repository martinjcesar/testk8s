#####################################################################
# Disks
#####################################################################

# resource "google_compute_disk" "os-disk" {
#     name = "os-disk"
#     type = "pd-standard"  // pd-ssd
#     zone = "${var.region}-${var.zone}"
#     size = "10"
#     image = "${var.disk_image}"

#     # lifecycle {
#     #         prevent_destroy = "false"
#     # }
# }

# resource "google_compute_disk" "data-disk" {
#     name = "data-disk"
#     type = "pd-standard"
#     zone = "${var.region}-${var.zone}"
#     size = "20"

#     # lifecycle {
#     #         prevent_destroy = "false"
#     # }
# }


#####################################################################
# VM Instances
#####################################################################
resource	"google_compute_instance"	"www"	{

		count		=	"${var.www_servers}"
		name		=	"www-${count.index+1}"
		machine_type	=	"${var.machine_type}"
		zone	=	"${var.region}-${var.zone}"
		
		boot_disk {
	    initialize_params {
	      image = "${var.disk_image}"
	      type = "pd-standard"  // pd-ssd
	      size = "10"
	    }
      #source = "${google_compute_disk.os-disk.self_link}"
	    auto_delete = "true" // Whether the disk will be auto-deleted when the instance is deleted
      device_name = "disk-${count.index+1}"      
    }

    # attached_disk {
    # 	source = "${google_compute_disk.data-disk.name}"
    # }
		
		metadata	{
				ssh-keys	=	"${var.ssh_username}:${file("${var.ssh_key}.pub")}"
		}

		tags	=	["www"]

		network_interface	{
				network	=	"default"
				access_config	{
						# ephemeral external ip address
				}
		}

		scheduling {
        preemptible = false
        on_host_maintenance = "MIGRATE"
        automatic_restart = true
    }

		# provisioner	"remote-exec"	{
		# 		connection	{
		# 				type = "ssh"
		# 				user				=	"${var.ssh_username}"
		# 				private_key	=	"${file("${var.ssh_key}")}"
		# 		}

		# 		inline	=	[
		# 				"sudo	yum	update	-y",
		# 				"sudo	yum	install	-y	docker",
		# 				"sudo	systemctl	enable	docker",
		# 				"sudo	systemctl	start	docker",
		# 		]
		# }


}