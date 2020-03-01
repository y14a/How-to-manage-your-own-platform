resource "google_compute_network" "datacenter" {
  name                    = "datacenter"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "main" {
  name           = "main"
  ip_cidr_range  = "10.0.0.0/16"
  network        = google_compute_network.datacenter.name
  description    = "Main subnet for connected all node directly"
  region         = "asia-northeast1"
}
