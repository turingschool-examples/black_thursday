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
    expect(@se.items).to be_an_instance_of(ItemRepository)
    expect(@se.merchants).to be_an_instance_of(MerchantRepository)
  end

  it 'returns instance of item repo with all items' do
    expect(@se.items).to be_a(ItemRepository)
    expect(@se.items.all[0]).to be_a(Item)
  end

  it 'returns instance of merchant repo with all merchants' do
    expect(@se.merchants).to be_a(MerchantRepository)
    expect(@se.merchants.all[0]).to be_a(Merchant)
  end
end
