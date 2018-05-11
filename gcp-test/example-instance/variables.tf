variable	"credentials_file"	{
		default			=	"gocd.json"
		description	=	"API	credentials	JSON	file"
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
		description	=	"Project	ID	to	use"
}

variable  "machine_type"  {
    default     = "f1-micro"
    description = "Machine  type"
}

variable  "zone"  {
    default         = "c"
    description = "Region Zone"
}

variable  "disk_image"  {   
    default     = "centos-cloud/centos-7"
    description = "Disk image"
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
    default = "2"
    description = "Amount of  www servers"
}