require 'rspec'
require './lib/sales_engine'
require './lib/items'
require './lib/items_repo'
require './lib/merchants'
require './lib/merchants_repo'

RSpec.describe ItemRepo do

  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })
  ir = se.items

  context 'it exists' do
    it 'exists' do
      expect(ir).to be_instance_of(ItemRepo)
    end
  end

  context 'methods' do
    it 'has attributes' do
      expect(ir.item_list[0]).to be_instance_of(Item)
      expect(ir.item_list.length).to eq(1367)
    end

    xit 'can find all instances of items' do

    end

    xit 'can find by item id' do

    end

    xit 'can find by item name' do

    end

    xit 'can find all items by description' do

    end

    xit 'can find all items by price' do

    end

    xit 'can find all items by price in a range' do

    end

    xit 'can find by merchant id' do

    end

    xit 'can create a new item' do

    end

    xit 'can update an item' do

    end

    xit 'can delete an item' do

    end
  end
end
