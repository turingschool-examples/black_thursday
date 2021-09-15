require 'simplecov'
SimpleCov.start
require './lib/merchant_repository'


RSpec.describe 'MerchantRepository' do

it "#all returns an array of all merchant instances" do
    expected = engine.merchants.all
    expect(expected.count).to eq 475
  end

  xit "#find_by_id finds a merchant by id" do
    id = 12335971
    expected = engine.merchants.find_by_id(id)

    expect(expected.id).to eq 12335971
    expect(expected.name).to eq "ivegreenleaves"
  end

  xit "#find_by_id returns nil if the merchant does not exist" do
    id = 101
    expected = engine.merchants.find_by_id(id)

    expect(expected).to eq nil
  end
end
