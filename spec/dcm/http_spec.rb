require 'spec_helper'

describe DCM::Http do
  describe 'URI handling' do
    before do
      DCM.access_key = 'abcd'
      DCM.secret_key = '1234'
    end

    let(:base) {DCM::Client.new}

    it '#sign_request' do
      expect(
          base.send(:sign_request, 'geography/Cloud', '1389055636')
      ).to match(/^([A-Za-z0-9+\/]{4})*([A-Za-z0-9+\/]{4}|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{2}==)$/im)
    end

    it '#set_url strip trailing slash' do
      DCM.endpoint = 'http://example.com/'
      base = DCM::Client.new
      expect( base.send(:set_url, 'geography/Cloud').to_s ).to eq('http://example.com/2013-12-07/geography/Cloud')
    end
    it '#set_url not strip anything' do
      DCM.endpoint = 'http://example.com'
      base = DCM::Client.new
      expect( base.send(:set_url, 'geography/Cloud').to_s ).to eq('http://example.com/2013-12-07/geography/Cloud')
    end

    after do
      DCM.reset
    end

  end
end
