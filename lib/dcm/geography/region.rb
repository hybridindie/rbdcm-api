require 'json'

module DCM
  module Geography
    module Region

      def regions
        request = self.get('geography/Region')
        json = JSON.parse( request.body )
        return_struct(json)
      end

      private

      def return_struct(json)
        json['regions'].each { |r| OpenStruct.new(r) }
      end

    end
  end
end
