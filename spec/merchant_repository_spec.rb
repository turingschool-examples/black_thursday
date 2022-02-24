#merchant_rep_spec
require './lib/merchant_repository'
require './lib/merchant'
require 'pry'

RSpec.describe MerchantRepository do
  before(:each) do
    # @mr = MerchantRepository.new
  end

  # it 'exists' do
  #   expect(@mr).to be_a(MerchantRepository)
  # end

  it "can return an array of #all elements within the merchant.csv file" do
  expect(mr.all.length).to eq(475)
  end

end
