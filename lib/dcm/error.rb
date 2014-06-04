module DCM
  class Error < StandardError
    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    class ConfigurationError < ::ArgumentError
    end
  end
end
