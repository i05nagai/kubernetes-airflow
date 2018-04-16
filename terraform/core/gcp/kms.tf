# If we destroy this resource, key is not deleted.
# However, its' state is removed.
# See https://www.terraform.io/docs/providers/google/r/google_kms_key_ring.html
#
resource "google_kms_key_ring" "asia_northeast1" {
  name     = "${local.common["prefix"]}asia-northeast1"
  location = "asia-northeast1"

  lifecycle {
    prevent_destroy = true
  }
}

#
# If we destroy this resource, key is not deleted.
# However, all key versions are deleted and its' state is removed.
# See https://www.terraform.io/docs/providers/google/r/google_kms_crypto_key.html
#
resource "google_kms_crypto_key" "default" {
  name     = "${local.common["prefix"]}default"
  key_ring = "${google_kms_key_ring.asia_northeast1.id}"

  lifecycle {
    prevent_destroy = true
  }
}

#
# give roles to cloud container builder in dev and stg
#
resource "google_kms_crypto_key_iam_binding" "container_builder" {
  count         = "${local.flag["env_dev"] + local.flag["env_stg"] }"
  crypto_key_id = "${google_kms_crypto_key.default.id}"
  role          = "roles/cloudkms.cryptoKeyDecrypter"

  members = [
    "",
  ]
}
