variable	"credentials_file"	{
	default			=	"gocd.json"
	description	=	"API credentials JSON file"
}

variable	"region"	{
	default			=	"us-central1"
	description	=	"Region	name"
}

variable  "region_zone"  {
    default     = "us-central1-c"
    description = "Availability zone"
}

variable	"project_name"	{
	default			=	"default-project"
	description	=	"Project ID to use"
}

variable  "machine_type"  {
    default     = "f1-micro"
    description = "Machine  type"
}

variable  "zone"  {
    default         = "c"
    description = "Region Zone"
}

variable  "disk_image_centos"  {   
    default     = "centos-cloud/centos-7"
    description = "Centos 7  disk image"
}

variable  "disk_image_ubuntu"  {   
    default     = "ubuntu-os-cloud/ubuntu-1404-lts"
    description = "Ubuntu disk image"
}

variable  "ssh_key" {
    default     = "keys/admin_key"
    description = "SSH  key"
}

variable  "ssh_username"  {
    default     = "root"
    description = "The  SSH username  to  use"
}

variable  "www_servers" {
    default = "1"
    description = "Amount of  www servers"
}