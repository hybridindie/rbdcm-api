require 'dcm/error'

module DCM
  class Client
    include Http
    include API
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

    private

    # Type Check Values
    def validate_options!
      Configuration::VALID_CONFIG_KEYS.each do |option|
        fail(DCM::Error::MissingConfigurationError, "Missing #{option} value: #{option} can not be nil.") if self.send(option).nil?
        fail(DCM::Error::ConfigurationError, "Invalid #{option} specified: #{self.send(option).inspect} must be a string or symbol.") unless self.send(option).is_a?(String) || self.send(option).is_a?(Symbol)
      end
    end
  end
end
