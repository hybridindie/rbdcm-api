require 'dcm/error'

module DCM
  class Client
    # Define the same set of accessors
    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(opt={})
      merged_options = DCM.options.merge(opt)

      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
      yield self if block_given?

      validate_options!
    end

    def get(service)
      url = set_url(service)
      timestamp = (Time.now.to_i * 1000).to_s
      connection = Net::HTTP::Get.new(url.path, set_headers( service, timestamp ))

      results = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme.eql?('https')) do |http|
        http.request(connection)
      end
      results
    end

    private

    def sign_request(service, timestamp)
      parts = []
      parts << DCM.access_key << DCM.method << set_url(service).path << timestamp << DCM.user_agent
      to_sign = parts.join(":")

      digest = OpenSSL::HMAC.digest('sha256', DCM.secret_key.to_s, to_sign.to_s).to_s
      Base64.encode64(digest).strip
    end

    def set_headers(service, timestamp)
      {'user-agent' => DCM.user_agent,
       'x-esauth-access' => DCM.access_key,
       'x-esauth-timestamp' => timestamp,
       'x-esauth-signature' => sign_request(service, timestamp),
       'x-es-details' => 'basic',
       'Accept' => 'application/json'}
    end

    def set_url(service)
      # Check and clean any end slash from our endpoints
      URI.parse("#{DCM.endpoint.sub(/(\/)+$/,'')}/#{DCM.api_version}/#{service}")
    end

    # Type Check Values
    def validate_options!
      Configuration::VALID_CONFIG_KEYS.each do |option|
        fail(DCM::Error::MissingConfigurationError, "Missing #{option} value: #{option} can not be nil.") if self.send(option).nil?
        fail(DCM::Error::ConfigurationError, "Invalid #{option} specified: #{self.send(option).inspect} must be a string or symbol.") unless self.send(option).is_a?(String) || self.send(option).is_a?(Symbol)
      end
    end
  end
end
