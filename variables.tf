variable "authorized_keys" {
  default     = [""]
  description = "List of public keys used for SSH connections"
}

variable "image" {
  default     = "linode/ubuntu20.04"
  description = "Image used for deployment"
}

variable "group" {
  default     = "twitchandtear"
  description = "Display group"
}

variable "name" {
  default     = "twitchandtear"
  description = "Hostname of the system"
}

variable "private_key" {
  default     = ""
  description = "Private SSH key for the root user"
}

variable "region" {
  default     = "us-central"
  description = "Region to clone in"
}

variable "root_pass" {
  default     = ""
  description = "Password for the persistent user"
}

variable "stream_key" {
  default     = ""
  description = "Stream key for Twitch"
}

variable "tags" {
  default     = [ "games" ]
  description = "Tags to apply"
}

variable "target_host" {
  default     = ""
  description = "Target Zandronum server"
}

variable "type" {
  default     = "g6-nanode-2"
  description = "Type of instance"
}

variable "wads_upload_dir" {
  default     = ""
  description = "Directory path containing all files to upload to /data/wads"
}