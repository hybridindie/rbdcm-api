require 'spec_helper'

describe DCM::Configuration do

  DCM::Configuration::VALID_CONFIG_KEYS.each do |key|
    describe "##{key}" do
      it 'should return the default value' do
        DCM.send(key).should eq DCM::Configuration.const_get(key.upcase)
      end
    end
  end

end
