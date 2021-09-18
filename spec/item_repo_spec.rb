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
    expect(results.unit_price).to eq(38.0)
    expect(results2).to eq(nil)
  end

  it 'it can find an item by name' do
    results = @engine.items.find_by_name('510+ RealPush Icon Set')
    results2 = @engine.items.find_by_name('Tea For Bearded Women')
    expect(results.id).to eq(263395237)
    expect(results.id).to eq(263395237)
    expect(results.unit_price).to eq(12.0)
    expect(results2).to eq(nil)
  end

  it 'can find all with descriptions' do
    results =  @engine.items.find_all_with_description('Free standing')
    results2 = @engine.items.find_all_with_description('adfadf')
    expect(results.first.id).to eq(263396013)
    expect(results.first.unit_price).to eq(7.0)
    expect(results2).to eq([])
  end

  it "can find all with price" do
    results = @engine.items.find_all_by_price(13.0)
    expect(results.first.merchant_id).to eq(12334185)
    expect(results.first.id).to eq(263395617)
    results2 = @engine.items.find_all_by_price(0.000001)
    expect(results2).to eq([])
  end

  it "can find_all_by_price_in_range " do
    results = @engine.items.find_all_by_price_in_range(13.0..18.0)
    expect(results.first.id).to eq(263395617)
  end

  it '#creates attributes' do
    results = @engine.items.create({
        name: "Capita Defenders of Awesome 2018",
        description: "This board both rips and shreds",
        unit_price: BigDecimal(399.99, 5),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 25
      })
    expect(results.last.id).to eq(263567475)
  end

  xit '#updates attributes' do
    results = @engine.items.create({
        name: "Capita Defenders of Awesome 2018",
        description: "This board both rips and shreds",
        unit_price: BigDecimal(399.99, 5),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 25
      })

    # update = @engine.items.update(263567475, {unit_price: BigDecimal(379.99, 5)})
    expect(results.last.unit_price).to eq(379.99)
  end

  it '#delete' do
    @engine.items.delete(263567474)
    expected = @engine.items.find_by_id(263567474)
  expect(expected).to eq nil
  end

end
