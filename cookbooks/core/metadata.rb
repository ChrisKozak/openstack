maintainer       "Cloud Infrastructure"
maintainer_email "csf@ultimatesoftware.com"
license          "our license"
description      "Installs basic tools to manage any instance"
long_description ""
version          "0.0.1"

supports 'ubuntu'
supports 'windows'

recipe "core::download_product_artifacts_prereqs", "Sets up prereqs for downloading product artifacts"
recipe "core::download_vendor_artifacts_prereqs", "Sets up prereqs for downloading vendor artifacts"
