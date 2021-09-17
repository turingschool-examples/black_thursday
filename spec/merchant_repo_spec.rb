require 'simplecov'
SimpleCov.start
require './lib/merchant_repository'


RSpec.describe 'MerchantRepository' do
  before (:each) do
    @engine = SalesEngine.from_csv({
                                items: './data/items.csv',
                                merchants: './data/merchants.csv'
                                  })
  end
  it "#all returns an array of all merchant instances" do
    expected = @engine.merchants.all
    expect(expected.count).to eq 475
  end

  it "#find_by_id finds a merchant by id" do
    id = 12335971
    expected = @engine.merchants.find_by_id(id)

    expect(expected.id).to eq(12335971)
    expect(expected.name).to eq('ivegreenleaves')
  end

  it "#find_by_id returns nil if the merchant does not exist" do
    id = 101
    expected = @engine.merchants.find_by_id(id)

    expect(expected).to eq(nil)
  end

  it "#find_by_name finds a merchant by name" do
    name = 'Teeforbeardedmen'
    expected = @engine.merchants.find_by_name(name)

    expect(expected.id).to eq(12335541)
    expect(expected.name).to eq(name)
  end

  it '#find_by_name returns nil if the merchant does not exist' do
    name_2 = 'Teaforbeardedwomen'
    expected = @engine.merchants.find_by_name(name_2)

    expect(expected).to eq(nil)
  end

  it '#find_all_by_name returns an array of all merchants with name' do
    name = 'Moon'
    name2 = 'style'
    expected = @engine.merchants.find_all_by_name(name)
    expected2 = @engine.merchants.find_all_by_name(name2)
    expect(expected.count).to eq(3)
    expect(expected2.count).to eq(3)
    expect(expected.first.name).to eq("IvyMoonCat")
    expect(expected2.first.name).to eq("justMstyle")
  end

  xit '#create a new merchant instance with attributes' do
  end

  xit '#updates merchant instance by id with new attributes' do
  end

  xit '#delete can delete an instance of merchant by id' do
    id = 12335971
    expected = @engine.merchants.delete(id)

    expect(expected.id).to eq(nil)
    expect(expected.name).to eq(nil)
  end
end
