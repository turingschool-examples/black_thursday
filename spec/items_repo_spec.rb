require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/sales_engine'
require './lib/items'
require './lib/items_repo'

RSpec.describe ItemRepo do

  se = SalesEngine.from_csv({
  :items     => "./data/items.csv"
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

    it 'can update an item' do
      original_time = ir.find_by_id(263567475).updated_at
      attributes = {
        unit_price: 379.99,
        # name: "Capita Defenders of Awesome 2018"
      }
      ir.update(263567475, attributes)
      expected = ir.find_by_id(263567475)
      expect(expected.unit_price.to_f).to eq 379.99
      expect(expected.name).to eq "Capita Defenders of Awesome 2018"
      expect(expected.updated_at).to be > original_time
    end

    it "#update cannot update id, created_at, or merchant_id" do
      attributes = {
        id: 270000000,
        created_at: Time.now,
        merchant_id: 1
      }
      ir.update(263567475, attributes)
      expected = ir.find_by_id(270000000)
      expect(expected).to eq nil
      expected = ir.find_by_id(263567475)
      expect(expected.created_at).not_to eq attributes[:created_at]
      expect(expected.merchant_id).not_to eq attributes[:merchant_id]
    end

    it "#update on unknown item does nothing" do
      ir.update(270000000, {})
    end

    it 'can delete an item' do
      ir.delete(263567475)
      expected = ir.find_by_id(263567475)
      expect(expected).to eq nil
    end

    it "#delete on unknown item does nothing" do
      ir.delete(270000000)
    end
  end
end
