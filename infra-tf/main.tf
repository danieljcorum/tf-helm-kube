provider "google" {
  project     = "hip-runner-276102"
  region      = "us-east4"
}

resource "google_container_cluster" "primary" {
  name = "dan-gke-cluster"
  location = "us-east4-a"
  initial_node_count = 1
  remove_default_node_pool = true
  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "main" {
  name = "dan-gke-node-pool"
  location = "us-east4-a"
  cluster = google_container_cluster.primary.name
  node_count = 2

  node_config {
    preemptible = true
    machine_type = "e2-small"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
