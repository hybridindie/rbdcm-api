require 'spec_helper'

describe DCM::Base do
  before do
    @keys = DCM::Configuration::VALID_CONFIG_KEYS
    @config = {:access_key => 'ak', :secret_key => 'of', :endpoint => 'ep', :api_version => 'rf', :user_agent => 'ua', :method => 'hm' }
  end

  describe '#new' do
    it 'raises an exception' do
      expect { DCM::Base.new( access_key: nil ).to raise_exception(DCM::Error::ConfigurationError)}
    end
  end

  describe '#options' do
    it 'returns false if any options are missing' do
      client = DCM::Base.new
      expect(client.options?).to be false
    end
    it 'returns true if all options are set' do
      client = DCM::Base.new(access_key: 'abcd', secret_key: '1234')
      puts client.options
      expect(client.options?).to be true
    end
  end

  describe 'module configuration' do
    before do
      DCM.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    it 'should inherit module configuration' do
      @keys.each do |key|
        api = DCM::Base.new
        api.send(key).should eq(key)
      end
    end
  end

  describe 'with class configuration' do


    it 'should override module configuration' do
      api = DCM::Base.new(@config)
      @keys.each do |key|
        api.send(key).should eq(@config[key])
      end
    end

    it 'should override module configuration after' do
      api = DCM::Base.new

      @config.each do |key, value|
        api.send("#{key}=", value)
      end

      @keys.each do |key|
        api.send("#{key}").should eq(@config[key])
      end
    end

  end

  describe 'URI handling' do
    before do
      DCM.access_key = 'abcd'
      DCM.secret_key = '1234'
    end

    let(:base) {DCM::Base.new}

    it '#sign_request' do
      base.send(:sign_request, 'geography/Cloud', '1389055636').should match(/^([A-Za-z0-9+\/]{4})*([A-Za-z0-9+\/]{4}|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{2}==)$/im)
    end

    it '#set_url strip trailing slash' do
      DCM.endpoint = 'http://example.com/'
      base = DCM::Base.new
      base.send(:set_url, 'geography/Cloud').to_s.should eq('http://example.com/2013-03-13/geography/Cloud')
    end
    it '#set_url not strip anything' do
      DCM.endpoint = 'http://example.com'
      base = DCM::Base.new
      base.send(:set_url, 'geography/Cloud').to_s.should eq('http://example.com/2013-03-13/geography/Cloud')
    end

  end

  after do
    DCM.reset
  end

end
