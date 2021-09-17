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
    results = @engine.items.find_by_id('263567474')
    expect(results.first.id).to eq("263567474")
    expect(results.first.unit_price).to eq("3800")
  end

  it 'it can find an item by name' do
    results = @engine.items.find_by_name('510+ RealPush Icon Set')
    expect(results.first.id).to eq("263395237")
    expect(results.first.unit_price).to eq("1200")
  end
end
