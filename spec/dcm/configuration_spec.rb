require 'spec_helper'

describe DCM::Configuration do

  after do
    DCM.reset
  end

  describe '.configure' do
    DCM::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do
        DCM.configure do |config|
          config.send("#{key}=", key)
          expect( DCM.send(key) ).to eq key
        end
      end
    end
  end

  DCM::Configuration::VALID_CONFIG_KEYS.each do |key|
    describe "##{key}" do
      it 'should return the default value' do
        expect( DCM.send(key) ).to eq DCM::Configuration.const_get(key.upcase)
      end
    end
  end

end
