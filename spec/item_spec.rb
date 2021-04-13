require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'
require 'pry'

RSpec.describe Item do
  describe '#initialize' do
    it 'exists' do
      item = Item.new(id: '263395617 ',
      name: 'Glitter scrabble frames ',
      description: 'Glitter scrabble frames ',
      unit_price: '1300 ',
      merchant_id: '12334185 ',
      created_at: '2016-01-11 11:51:37 UTC ',
      updated_at: '1993-09-29 11:56:40 UTC ')

      expect(item).to be_instance_of(Item)
      end
    it 'has attributes' do
      item = Item.new(id: '1',
      name: 'Cool Stuff',
      description: 'supaaa cool',
      unit_price: '1300',
      merchant_id: '12334185',
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '1993-09-29 11:56:40 UTC')

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
end
