resource "google_compute_instance" "ns" {
  name = "ns"
  machine_type = "n1-standard-1"
  zone = "asia-northeast1-a"
  description = "Internal name server"

  boot_disk {
    auto_delete = true
    initialize_params {
      image = "centos-cloud/centos-7-v20200205"
      size = 10
    }
  }

  network_interface {
    access_config {
    }

    subnetwork = google_compute_subnetwork.main.name
  }
}
