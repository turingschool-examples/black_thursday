require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'
require 'pry'

RSpec.describe Item do
  describe '#initialize' do
    it 'exists' do
      mock_item_repo = instance_double("ItemRepository")
      item = Item.new({
        id: '263395617 ',
        name: 'Glitter scrabble frames ',
        description: 'Glitter scrabble frames ',
        unit_price: '1300 ',
        merchant_id: '12334185 ',
        created_at: '2016-01-11 11:51:37 UTC ',
        updated_at: '1993-09-29 11:56:40 UTC '},
        mock_item_repo
      )
      expect(item).to be_instance_of(Item)
      end
    it 'has attributes' do
      mock_item_repo = instance_double("ItemRepository")
      item = Item.new({
        id: '1',
        name: 'Cool Stuff',
        description: 'supaaa cool',
        unit_price: '1300',
        merchant_id: '12334185',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'},
        mock_item_repo
      )
      expect(item.id).to eq(1)
      expect(item.name).to eq('Cool Stuff')
      expect(item.description).to eq('supaaa cool')
      expect(item.unit_price).to eq(0.13e4)
      expect(item.created_at.year).to eq(2016)
      expect(item.created_at).to be_instance_of(Time)
      expect(item.updated_at.year).to eq(1993)
      expect(item.updated_at).to be_instance_of(Time)
      expect(item.merchant_id).to eq(12334185)
    end
  end
  describe '#update' do
    it 'updates the updated_at timestamp' do
      mock_item_repo = instance_double("ItemRepository")
      item = Item.new({
        id: '1',
        name: 'Cool Stuff',
        description: 'supaaa cool',
        unit_price: '1300',
        merchant_id: '12334185',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'},
        mock_item_repo
      )
      item.update
      expect(item.updated_at.year).to eq(2021)
    end
  end
  describe '#format_unit_price' do
    it 'formats the unit price to a BigDecimal' do
      mock_item_repo = instance_double("ItemRepository")
      item = Item.new(
        {id: '1',
        name: 'Cool Stuff',
        description: 'supaaa cool',
        unit_price: '1300',
        merchant_id: '12334185',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'},
        mock_item_repo)
      item.unit_price = 1300
      item.format_unit_price
      expect(item.unit_price).to eq(0.13e4)
    end
  end
end
