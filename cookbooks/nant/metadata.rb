maintainer       'Cloud Infrastructure'
maintainer_email 'csf@ultimatesoftware.com'
license          'our license'
description      'Installs nant'
long_description ''
version          '0.0.1'

supports 'windows'

depends 'core'
depends 'windows'

recipe 'nant::default', 'Downloads and installs nant'