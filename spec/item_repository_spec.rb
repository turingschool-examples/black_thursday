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

  it 'finds all items by price' do
    price = BigDecimal(10_000)

    expected = @se.items.find_all_by_price(price)
    expect(expected.length).to eq(26)

    price = BigDecimal(1790)

    expected = @se.items.find_all_by_price(price)
    expect(expected.length).to eq(10)

    price = BigDecimal(12)

    expected = @se.items.find_all_by_price(price)
    expect(expected.length).to eq(0)
  end

  it 'can find all items within given price range' do
    range = (1000.00..20_000.00)
    expected = @se.items.find_all_by_price_in_range(range)

    expect(expected.length).to eq 954

    range = (200.00..250.00)
    expected = @se.items.find_all_by_price_in_range(range)

    expect(expected.length).to eq 32

    range = (0.00..20.00)
    expected = @se.items.find_all_by_price_in_range(range)

    expect(expected.length).to eq 1
  end

  it 'can find all items associated with a given merchant id' do
    merchant_id = 12_334_105
    expected = @se.items.find_all_by_merchant_id(merchant_id)

    expect(expected.length).to eq(3)

    merchant_id = 42
    expected = @se.items.find_all_by_merchant_id(merchant_id)

    expect(expected.length).to eq(0)
  end

  it '#create creates a new item instance' do
    attributes = {
      name: "Timmy's Tutus",
      description: 'Be the dancer you were meant to be.',
      unit_price: BigDecimal(20.00, 4),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 256
    }

    @se.items.create(attributes)
    expected = @se.items.find_by_id(263_567_475)
    expect(expected.name).to eq "Timmy's Tutus"
  end

  it '#update updates an item' do
    @se.items.create(
      name: "Timmy's Tutus",
      description: 'Be the dancer you were meant to be.',
      unit_price: BigDecimal(20.00, 4),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 256
    )

    original_time = @se.items.find_by_id(263_567_475).updated_at
    attributes = {
      unit_price: BigDecimal(25.00, 4), name: "Timmy's Tutus 2", description: "Dance Bitches!"
    }
    @se.items.update(263_567_475, attributes)
    expected = @se.items.find_by_id(263_567_475)
    expect(expected.unit_price).to eq 25.00
    expect(expected.name).to eq "Timmy's Tutus 2"
    expect(expected.description).to eq "Dance Bitches!"
    expect(expected.updated_at).to be >= original_time
  end
end
