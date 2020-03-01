resource "google_compute_firewall" "ingress-default" {
  name    = "ingress-default"
  network = "google_compute_network.datacenter.name"

  allow {
    protocol = "tcp"
    ports    = [ "22", "80", "443" ]
  }
}
