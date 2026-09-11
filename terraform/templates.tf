locals {
  acr_login_server          = azurerm_container_registry.acr.login_server
  storage_connection_string = azurerm_storage_account.storage_account.primary_connection_string
}

resource "local_file" "application_secret" {
  content = templatefile("${path.module}/templates/07-application-secret.yaml.tpl", {
    storage_connection_string = local.storage_connection_string
  })
  filename = "${path.module}/../kubernetes/07-application-secret.yaml"
}

resource "local_file" "user_service" {
  content = templatefile("${path.module}/templates/08-user-service.yaml.tpl", {
    acr_login_server = local.acr_login_server
  })
  filename = "${path.module}/../kubernetes/08-user-service.yaml"
}

resource "local_file" "student_service" {
  content = templatefile("${path.module}/templates/09-student-service.yaml.tpl", {
    acr_login_server = local.acr_login_server
  })
  filename = "${path.module}/../kubernetes/09-student-service.yaml"
}

resource "local_file" "lecturer_service" {
  content = templatefile("${path.module}/templates/10-lecturer-service.yaml.tpl", {
    acr_login_server = local.acr_login_server
  })
  filename = "${path.module}/../kubernetes/10-lecturer-service.yaml"
}

resource "local_file" "course_service" {
  content = templatefile("${path.module}/templates/11-course-service.yaml.tpl", {
    acr_login_server = local.acr_login_server
  })
  filename = "${path.module}/../kubernetes/11-course-service.yaml"
}

resource "local_file" "enrollment_service" {
  content = templatefile("${path.module}/templates/12-enrollment-service.yaml.tpl", {
    acr_login_server = local.acr_login_server
  })
  filename = "${path.module}/../kubernetes/12-enrollment-service.yaml"
}

resource "local_file" "frontend" {
  content = templatefile("${path.module}/templates/13-frontend.yaml.tpl", {
    acr_login_server = local.acr_login_server
  })
  filename = "${path.module}/../kubernetes/13-frontend.yaml"
}