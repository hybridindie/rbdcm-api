module DCM
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :user_agent, :method, :api_version].freeze
    VALID_OPTIONS_KEYS    = [:access_key, :secret_key].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    ENDPOINT    = 'https://api.enstratus.com/api/enstratus'
    API_VERSION = '2014-11-24'
    METHOD      = 'GET'
    USER_AGENT  = "Dell Cloud Manager Ruby Client #{DCM::VERSION}".freeze

    ACCESS_KEY  = nil
    SECRET_KEY  = nil

    # Build accessor methods for every config option
    attr_accessor *VALID_CONFIG_KEYS

    # Make sure we have the default values set when we get 'extended'
    def self.extended(base)
      base.reset
    end

    def reset
      self.endpoint    = ENDPOINT
      self.api_version = API_VERSION
      self.method      = METHOD
      self.user_agent  = USER_AGENT

      self.access_key  = ACCESS_KEY
      self.secret_key  = SECRET_KEY
    end

    def configure
      yield self
    end

    # Return the configuration values set in this module
    def options
      Hash[ *Configuration::VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end

  end
end
