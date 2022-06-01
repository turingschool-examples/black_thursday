require './lib/merchant'
require './lib/merchant_repository'


RSpec.describe MerchantRepository do

  # before :each do
  #   merchantrepository= MerchantRepository.new("./data/merchants.csv")
  # end

  it 'exists' do
    merchant = Merchant.new({:id => 5, :name => "Turing School"})


    expect(merchantrepository).to be_a(Merchant_Repository)
  end

  # it 'returns an array of all known merchants' do
  #   merchant = Merchant.new({:id => 5, :name => "Turing School"})
  #
  #
  #
  # end


end
