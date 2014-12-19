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
  module API

    include DCM::Admin::Account
    include DCM::Admin::Acl
    include DCM::Admin::BillingCode
    include DCM::Admin::Customer
    include DCM::Admin::Group
    include DCM::Admin::Job
    include DCM::Admin::Role
    include DCM::Admin::User

    include DCM::Geography::Cloud
    include DCM::Geography::DataCenter
    include DCM::Geography::Region

    include DCM::Infrastructure::MachineImage
    include DCM::Infrastructure::Server
    include DCM::Infrastructure::ServerAgent
    include DCM::Infrastructure::ServerProduct
    include DCM::Infrastructure::Snapshot
    include DCM::Infrastructure::Volume

  end
end
