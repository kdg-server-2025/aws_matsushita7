# ------------------------------
# Variables
# ------------------------------

# プリフィックスを設定
variable "prefix" {
  default = "tf-pg"
}

# プロジェクトを識別する一意の識別子を設定
variable "project" {
  default = "terraform-playground"
}

# プロジェクトのオーナーを設定
variable "owner" {
  default = "matsushita"
}

# DBのユーザ名を設定
variable "db_username" {
  description = "macha"
}

# DBのパスワードを設定
variable "db_password" {
  description = "matsutake404"
}



