require './lib/item_repository'
require './lib/sales_engine'
require 'csv'

RSpec.describe do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                items: './data/items.csv',
                                merchants: './data/merchants.csv'
                              })
    end
  it 'exists' do
    repo = ItemRepository.new('./data/items.csv')
    expect(repo).to be_an_instance_of(ItemRepository)
  end

  it 'adds keys to item instances array' do
    expect(@engine.items.all.count).to eq(1367)
  end

  it 'can find an item by id' do
    results = @engine.items.find_by_id(263567474)
    results2 = @engine.items.find_by_id('Camping Chair Actor')
    expect(results.id).to eq(263567474)
    expect(results.unit_price).to eq(3800)
    expect(results2).to eq(nil)
  end

  it 'it can find an item by name' do
    results = @engine.items.find_by_name('510+ RealPush Icon Set')
    results2 = @engine.items.find_by_name('Tea For Bearded Women')
    expect(results.id).to eq('263395237')
    expect(results.id).to eq(263395237)
    expect(results.unit_price).to eq(1200)
    expect(results2).to eq(nil)
  end

  it 'can find all with descriptions' do
    results =  @engine.items.find_all_with_description('Free standing')
    results2 = @engine.items.find_all_with_description('adfadf')
    expect(results.first.id).to eq(263396013)
    expect(results.first.unit_price).to eq(700)
    expect(results2).to eq([])
  end

  it "can find all with price" do
    results = @engine.items.find_all_by_price(1300)
    expect(results.first.merchant_id).to eq(12334185)
    expect(results.first.id).to eq(263395617)
    results2 = @engine.items.find_all_by_price(0.000001)
    expect(results2).to eq([])
  end

it "can find_all_by_price_in_range " do
  results = @engine.items.find_all_by_price_in_range(1300..1305)
  expect(results.first.id).to eq("263395617")
end



end
