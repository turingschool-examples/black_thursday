#merchant_rep_spec
require './lib/merchant_repository'
require './lib/merchant'
require 'pry'

RSpec.describe MerchantRepository do
  before(:each) do
    @se = SalesEngine.from_csv({
                                 items: './data/items.csv',
                                 merchants: './data/merchants.csv'
                               })
  end

  it 'exists' do
    expect(@se.merchants).to be_a(MerchantRepository)
  end


  xit "can return an array of #all elements within the merchant.csv file" do
  expect(@se.merchants.all.length).to eq(475)
  end

end
