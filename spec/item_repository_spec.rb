# item_repository_spec
require './lib/item_repository'
# require './lib/items'
require './lib/sales_engine'
require 'pry'
require 'bigdecimal'

RSpec.describe ItemRepository do
  before(:each) do
    @se = SalesEngine.from_csv({
                                 items: './data/items.csv',
                                 merchants: './data/merchants.csv'
                               })
  end

  it 'exists' do
    expect(@se.items).to be_a(ItemRepository)
  end

  it 'can return an array of #all items' do
    expect(@se.items.all.count).to eq(1367)
  end

  it 'can return an item id' do
    id = 263_567_376
    expected = @se.items.find_by_id(id)
    expect(expected.id).to eq(id)
    expect(expected.name).to eq('The Gold Coast, Chicago, Illinois')
  end

  it 'will return nil if improper id entered' do
    id = 0o00
    expected = @se.items.find_by_id(id)

    expect(expected).to eq(nil)
  end

  it 'can find by name' do
    name = 'Bird houses'
    expected = @se.items.find_by_name(name)

    expect(expected.id).to eq(263_565_028)
  end

  it 'can find by name :case-insensitive' do
    name = 'Bird hOuSes'
    expected = @se.items.find_by_name(name)

    expect(expected.id).to eq(263_565_028)
  end

  it 'find by name returns nil if invalid input' do
    name = 'Shermans Shoe Shop'
    expected = @se.items.find_by_name(name)

    expect(expected).to eq(nil)
  end

  it 'find by all by name' do
    name = 'hand'
    expected = @se.items.find_by_name(name)

    expect(expected).to eq(nil)
  end

  it '#find_all_with_description finds all items matching given description' do
    description = 'A bird house made of all natural material, hand crafted with love.'
    expected = @se.items.find_all_with_description(description)

    expect(expected.first.description).to eq(description)
    expect(expected.first.id).to eq(263_565_028)

    description = 'A bird house MADE of all natural material, HAND crafted with love.'
    expected = @se.items.find_all_with_description(description)

    expect(expected.first.id).to eq(263_565_028)

    description = 'shoes be clean'
    expected = @se.items.find_all_with_description(description)

    expect(expected.length).to eq(0)
  end

  it "finds all items by price" do
    price = BigDecimal(10000)

    expected = @se.items.find_all_by_price(price)
    expect(expected.length).to eq(26)

    price = BigDecimal(1790)

    expected = @se.items.find_all_by_price(price)
    expect(expected.length).to eq(10)

    price = BigDecimal(12)

    expected = @se.items.find_all_by_price(price)
    expect(expected.length).to eq(0)


  end
end
