module DCM
  module Http

    def get(service)
      url = set_url(service)
      timestamp = (Time.now.to_i * 1000).to_s
      connection = Net::HTTP::Get.new(url.path, set_headers( service, timestamp ))

      results = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme.eql?('https'), verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
        http.request(connection)
      end
      results
    end

    def post

    end


    def patch

    end
    alias_method :put, :patch

    def delete

    end

    def head

    end

    private
    def set_url(service)
      # Check and clean any end slash from our endpoints
      URI.parse("#{self.endpoint.sub(/(\/)+$/,'')}/#{self.api_version}/#{service}")
    end

    def set_headers(service, timestamp)
      {'user-agent' => self.user_agent,
       'x-esauth-access' => self.access_key,
       'x-esauth-timestamp' => timestamp,
       'x-esauth-signature' => sign_request(service, timestamp),
       'x-es-details' => 'basic',
       'Accept' => 'application/json'}
    end

    def sign_request(service, timestamp)
      parts = []
      parts << self.access_key << self.method << set_url(service).path << timestamp << self.user_agent
      to_sign = parts.join(":")

      digest = OpenSSL::HMAC.digest('sha256', self.secret_key.to_s, to_sign.to_s).to_s
      Base64.encode64(digest).strip
    end
  end
end
