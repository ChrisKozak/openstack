maintainer       "Cloud Infrastructure"
maintainer_email "csf@ultimatesoftware.com"
license          "our license"
description      "Deploys the UGF software to the environment"
long_description ""
version          "0.0.1"

supports "windows"

depends 'core'
depends 'powershell'

recipe "newgen::default", "Deploys New Gen websites"
recipe "newgen::download", "Downloads binaries"
recipe "newgen::migrate", "Runs migrate"
recipe "newgen::smoke_tests", "Runs smoke tests"

# Attributes from core cookbook
attribute "core/aws_access_key_id",
  :display_name => "aws access key id",
  :required => "required",
  :recipes => ["newgen::default", "newgen::download", "newgen::migrate"]

attribute "core/aws_secret_access_key",
  :display_name => "aws secret access key",
  :required => "required",
  :recipes => ["newgen::default", "newgen::download", "newgen::migrate"]

attribute "core/s3_bucket",
  :display_name => "s3 bucket for the UGF platform",
  :required => "optional",
  :default  => "ugfgate1",
  :recipes  => ["newgen::default", "newgen::download", "newgen::migrate"]

attribute "core/s3_repository",
  :display_name => "s3 repository for the services api",
  :required => "optional",
  :default  => "NewGen",
  :recipes  => ["newgen::default", "newgen::download", "newgen::migrate"]

attribute "route53/domain",
  :display_name => "route 53 domain",
  :required => "optional",
  :recipes => ["newgen::default"]

attribute "route53/prefix",
  :display_name => "route 53 prefix",
  :required => "optional",
  :recipes => ["newgen::default"]

# Attributes from newgen cookbook
attribute "newgen/application_server",
  :display_name => "application server",
  :required => "required",
  :recipes => ["newgen::default"]

attribute "newgen/binaries_artifacts",
  :display_name => "binaries artifacts",
  :required => "required",
  :recipes => ["newgen::default", "newgen::download", "newgen::migrate"]

attribute "newgen/binaries_revision",
  :display_name => "binaries revision",
  :required => "required",
  :recipes => ["newgen::default", "newgen::download", "newgen::migrate"]

attribute "newgen/database_password",
  :display_name => "database password",
  :required => "required",
  :recipes => ["newgen::default", "newgen::migrate", "newgen::smoke_tests"]

attribute "newgen/database_server",
  :display_name => "database server",
  :required => "required",
  :recipes => ["newgen::default", "newgen::migrate", "newgen::smoke_tests"]

attribute "newgen/database_user",
  :display_name => "database user",
  :required => "required",
  :recipes => ["newgen::default", "newgen::migrate", "newgen::smoke_tests"]

attribute 'elmah/database_user',
  :display_name => 'database user',
  :required => 'required',
  :recipes => ['newgen::default']

attribute 'elmah/database_password',
  :display_name => 'database password',
  :required => 'required',
  :recipes => ['newgen::default']

attribute 'elmah/logging_server',
  :display_name => 'logging server',
  :required => 'required',
  :recipes => ['newgen::default']