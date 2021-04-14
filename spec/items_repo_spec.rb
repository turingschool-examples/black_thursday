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

    it 'can find all instances of items' do
      expect(ir.all.length).to eq(1367)
    end

    it 'can find by item id' do
      expect(ir.find_by_id(263395237)).to be_instance_of(Item)
      expect(ir.find_by_id(192)).to eq(nil)
      expect(ir.find_by_id(263395237)).to eq(ir.item_list[0])
    end

    it 'can find by item name' do
      expect(ir.find_by_name("510+ RealPush Icon Set")).to be_instance_of(Item)
      expect(ir.find_by_name("510+ RealPush Icon Set")).to eq(ir.item_list[0])
      expect(ir.find_by_name("510+ realpush icon set")).to eq(ir.item_list[0])
    end

    it 'can find all items by description' do
      description = "A large Yeti of sorts, casually devours a cow as the others watch numbly."
      expected = ir.find_all_with_description(description)
      expect(expected.first.description).to eq description
      expect(expected.first.id).to eq 263550472
      description = "A LARGE yeti of SOrtS, casually devoURS a COw as the OTHERS WaTch NUmbly."
      expected = ir.find_all_with_description(description)
      expect(expected.first.id).to eq 263550472
      description = "Sales Engine is a relational database"
      expected = ir.find_all_with_description(description)
      expect(expected.length).to eq 0
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
