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


  it "can return an array of #all elements within the merchant.csv file" do
  expect(@se.merchants.all.length).to eq(475)
  end

  it "can find a merchant using id" do
    id = 12334159
    expected = @se.merchants.find_by_id(12334159)
    expect(expected.name).to eq('SassyStrangeArt')
  end

  it "#find by id returns nil on merch does not exist" do
    id = 1
    expected = @se.merchants.find_by_id(id)

    expect(expected).to eq(nil)
  end

  it 'can #find_by_name merchant' do
    name = 'SassyStrangeArt'
    expected = @se.merchants.find_by_name(name)

    expect(expected.id).to eq(12334159)
  end

  it "#find_by_name is case insensitive" do
    name = 'sassystrangeart'
    expected = @se.merchants.find_by_name(name)

    expect(expected.id).to eq(12334159)
  end

  it "#find_by_name returns nil when merchant does not exist" do
    name = "SassyStrange"
    expected = @se.merchants.find_by_name(name)

    expect(expected).to eq(nil)
  end

end
