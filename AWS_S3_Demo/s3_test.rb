
require 'econfig'
require ' aws-sdk-s3'

extend Econfig::Shortcut
Econfig.env = 'development'
Econfig.root = '.'