# item_repository_spec
require './lib/item_repository'
# require './lib/items'
require './lib/sales_engine'
require 'pry'

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
    fragment = 'hand'
    expected = @se.items.find_by_name(name)

    expect(expected).to eq(nil)
  end

  it "#find_all_with_description finds all items matching given description" do
  description =  'beautiful bracelet from the North Locals believe that it will bring luck and energy.'
  expected = @se.items.find_all_with_description(description)

  expect(expected.first.description).to eq (description)
  expect(expected.first.id).to eq(263_510_466)

  description = 'beautiful BRACELET from the NOrth lOcals believe that it will bring luck and energy.'
  expected = @se.items.find_all_with_description(description)

  expect(expected.first.id).to eq

  description =
  expected = @se.items.find_all_with_description(description)

  expect(expected.length).to eq
end

end
