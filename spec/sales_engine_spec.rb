require_relative './spec_helper'

RSpec.describe SalesEngine do
  before :each do
    @se = SalesEngine.new({items:'spec/fixtures/items.csv', merchants:'spec/fixtures/merchants.csv'})
  end

  it 'exists' do
    expect(@se).to be_a(SalesEngine)
  end

  it 'has attributes' do
    #Change to 'items' / 'merchants'
    expect(@se.items_repo).to be_an_instance_of(ItemRepository)

    expect(@se.merchants_repo).to be_an_instance_of(MerchantRepository)
  end
end
