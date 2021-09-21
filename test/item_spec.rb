require './lib/item'
require './lib/itemrepository'
require 'bigdecimal'
require 'bigdecimal/util'
require 'objspace'

RSpec.describe Item do

  describe "instantiation" do

    it "can create an item" do
      i = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(1099.0,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
        })

      expect(i).to be_an_instance_of(Item)

      expect(i.id).to eq(1)
      expect(i.name).to eq("Pencil")
      expect(i.description).to eq("You can use it to write things")
      expect(i.unit_price).to eq(BigDecimal(10.99,4))
      expect(i.created_at).to be_an_instance_of(Time)
      expect(i.updated_at).to be_an_instance_of(Time)
      expect(i.merchant_id).to eq(2)
    end

    it "can return the price of item in dollars (float)" do
      b = Item.new({
        :id          => 3,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(1099.0,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
        })

      expect(b.unit_price_to_dollars).to be_a(Float)
    end

  end
end
