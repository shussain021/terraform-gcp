data "google_compute_network" "existing_vpc" {
  name    = var.vpc_name
  project = var.project_id
}

data "google_compute_subnetwork" "existing_subnet" {
  name    = var.subnet_name
  region  = var.region
  project = var.project_id
}

resource "google_storage_bucket" "static-site" {
  name     = var.bucket_name
  location = var.location
  project  = var.project_id
  public_access_prevention = "enforced"
  versioning {
    enabled = true
  }
}

resource "google_compute_instance" "default" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2504-arm64"
      size = var.disk_size
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.existing_subnet
  }
}

resource "google_sql_database_instance" "instance" {
  name             = var.sql_instance_name
  region           = var.region
  database_version = var.database_version
  settings {
    tier = var.db_type
  }

  deletion_protection  = true
}

resource "google_sql_database" "main_database" {
  for_each = toset(var.db_name)  
  name     = each.key
  instance = google_sql_database_instance.instance.name
  depends_on = [ google_sql_database_instance.instance, ]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_+={}:?"
}

resource "google_sql_user" "main_user" {
  name     = var.db_username
  instance = google_sql_database_instance.instance.name
  password = random_password.password.result
  depends_on = [ google_sql_database_instance.instance,random_password.password, ]
}

resource "google_secret_manager_secret" "my_secret" {
  project = var.project_id
  secret_id = var.secret_name

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "my_secret_version" {
  secret      = google_secret_manager_secret.my_secret.id
  secret_data = random_password.password.result
  depends_on = [ google_secret_manager_secret.my_secret,random_password.password, ]
}

resource "google_compute_firewall" "postgres-rules" {
  project     = var.project_id
  name        = var.fw_rule
  network     = data.google_compute_network.existing_vpc
  description = "Creates firewall rule for postgres"

  allow {
    protocol  = "tcp"
    ports     = ["5432",]
  }
}