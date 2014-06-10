require 'net/http'
require 'openssl'
require 'json'
require 'base64'
require 'pp'

require 'dcm/version'
require 'dcm/configuration'
require 'dcm/http'
require 'dcm/client'

require 'dcm/admin/account'
require 'dcm/admin/acl'
require 'dcm/admin/billing_code'
require 'dcm/admin/customer'
require 'dcm/admin/group'
require 'dcm/admin/job'
require 'dcm/admin/role'
require 'dcm/admin/user'

require 'dcm/geography/cloud'
require 'dcm/geography/data_center'
require 'dcm/geography/region'

require 'dcm/infrastructure/machine_image'
require 'dcm/infrastructure/server'
require 'dcm/infrastructure/server_agent'
require 'dcm/infrastructure/server_product'
require 'dcm/infrastructure/snapshot'
require 'dcm/infrastructure/volume'

module DCM
  extend Configuration
end
