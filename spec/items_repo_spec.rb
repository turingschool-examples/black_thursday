require 'rspec'
require 'bigdecimal'
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

    it 'can find all items by price' do
      price = BigDecimal(25)
      expected =ir.find_all_by_price(price)

      expect(expected.length).to eq 79

      price = BigDecimal(10)
      expected = ir.find_all_by_price(price)

      expect(expected.length).to eq 63

      price = BigDecimal(20000)
      expected = ir.find_all_by_price(price)

      expect(expected.length).to eq 0
    end

    it 'can find all items by price in a range' do
      range = (1000.00..1500.00)
      expected = ir.find_all_by_price_in_range(range)
      expect(expected.length).to eq 19

      range = (10.00..150.00)
      expected = ir.find_all_by_price_in_range(range)

      expect(expected.length).to eq 910

      range = (10.00..15.00)
      expected = ir.find_all_by_price_in_range(range)

      expect(expected.length).to eq 205

      range = (0..10.0)
      expected = ir.find_all_by_price_in_range(range)

      expect(expected.length).to eq 302
    end

    it 'can find by merchant id' do
      merchant_id = 12334326
      expected = ir.find_all_by_merchant_id(merchant_id)
      expect(expected.length).to eq 6
      merchant_id = 12336020
      expected = ir.find_all_by_merchant_id(merchant_id)
      expect(expected.length).to eq 2
    end

    it 'can create a new item' do
      attributes = {
        name: "Capita Defenders of Awesome 2018",
        description: "This board both rips and shreds",
        unit_price: BigDecimal(399.99, 5),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 25
      }
      ir.create(attributes)
      expected = ir.find_by_id(263567475)
      expect(expected.name).to eq "Capita Defenders of Awesome 2018"
    end

    xit 'can update an item' do

    end

    xit 'can delete an item' do

    end
  end
end
