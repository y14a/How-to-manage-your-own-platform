resource "google_compute_instance" "ns" {
  name = "ns"
  machine_type = "n1-standard-1"
  zone = "asia-northeast1-a"
  description = "Internal name server"

  disk {
    image = ""
  }

  network_interface {
    access_config {
    }

    subnetwork = "${google_compute_subnetwork.main.name}"
  }
}
