maintainer       'Cloud Infrastructure'
maintainer_email 'csf@ultimatesoftware.com'
license          'our license'
description      'Installs psexec'
long_description ''
version          '0.0.1'

supports 'windows'

depends 'core'
depends 'windows'

recipe 'psexec::default', 'Downloads and installs psexec'