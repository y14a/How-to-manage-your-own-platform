resource "google_compute_firewall" "ingress-default" {
  name      = "ingress-default"
  network   = google_compute_network.datacenter.name
  direction = "INGRESS"

  allow {
    protocol  = "tcp"
    ports     = [ "22", "80", "443" ]
  }
  allow {
    protocol  = "tcp"
    ports     = [ "22", "80", "443" ]
  }
}

resource "google_compute_firewall" "egress-default" {
  name      = "egress-default"
  network   = google_compute_network.datacenter.name
  direction = "EGRESS"

  allow {
    protocol  = "tcp"
    ports     = [ "22", "80", "443" ]
  }
}
