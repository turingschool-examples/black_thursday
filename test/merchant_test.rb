require 'simplecov'
SimpleCov.start
require './test/merchant'

RSpec.describe Merchant do

  it 'exists' do
    merchant = Merchant.new

    expect(merchant).to be_instance_of(Merchant)
  end

end
