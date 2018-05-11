#####################################################################
#  GKE - Google Kubernetes Cluster
#####################################################################

resource "google_container_cluster" "mykube" {

  name = "mykube"
  zone = "us-central1-c"

  initial_node_count = 2

  additional_zones = [
    "us-central1-a"    
  ]

  cluster_ipv4_cidr = "${var.container_cidr_range}"

  master_auth {
    username = "${var.cluster_username}"
    password = "${var.cluster_password}"
  }

  network = "${google_compute_network.vpc-1.self_link}"
  subnetwork = "${google_compute_subnetwork.subnet-a.self_link}"
  monitoring_service = "monitoring.googleapis.com"
  logging_service = "logging.googleapis.com"
  
  #node_version = "1.6.6"
  node_config {
    machine_type =  "f1-micro"  # "n1-standard-1"
    disk_size_gb = "20"
  
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/datastore",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]

    labels {
      foo = "bar"
    }

    tags = ["foo", "bar"]    
  }
}
