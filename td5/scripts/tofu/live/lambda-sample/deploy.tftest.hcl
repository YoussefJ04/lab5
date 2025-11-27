run "deploy" {
  command   = "apply"
  arguments = ["-auto-approve"]
}

data "http" "test_endpoint" {
  # utilise la valeur de l'output api_endpoint défini dans main.tf
  url = run.deploy.outputs["api_endpoint"]
}

# Vérifie le code HTTP
assert {
  condition     = data.http.test_endpoint.status_code == 200
  error_message = "Unexpected status code: ${data.http.test_endpoint.status_code}"
}

# Vérifie le corps de la réponse
assert {
  condition     = data.http.test_endpoint.response_body == "Lab 5 reussi"
  error_message = "Unexpected body: ${data.http.test_endpoint.response_body}"
}
