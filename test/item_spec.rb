require './lib/item'
require './lib/itemrepository'
require 'bigdecimal'
require 'objspace'

RSpec.describe Item do

  describe "instantiation" do

    it "can create an item" do
      i = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
        })

      expect(i).to be_an_instance_of(Item)
    end

    it "can return the price of item in dollars (float)" do
      b = Item.new({
        :id          => 3,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
        })

      expect(b.unit_price_to_dollars).to be_a(Float)
    end

    xit "can return an array of all know Item instances" do


      i = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
        })

      a = Item.new({
          :id           => 5,
          :name         => "Water Bottles",
          :description  => "You can use it to drink things",
          :unit_price   => BigDecimal(15.99, 4),
          :created_at   => Time.now,
          :updated_at   => Time.now,
          :merchant_id  => 10
          })
      $csv = [
        {
          :id          => 1,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal(10.99,4),
          :created_at  => Time.now,
          :updated_at  => Time.now,
          :merchant_id => 2
        },
          {
              :id           => 5,
              :name         => "Water Bottles",
              :description  => "You can use it to drink things",
              :unit_price   => BigDecimal(15.99, 4),
              :created_at   => Time.now,
              :updated_at   => Time.now,
              :merchant_id  => 10
              }]

      Item.add_from_csv(nil)
      expect(Item.all).to eq([i, a])
    end

    it "can find by id" do

        i = Item.new({
          :id          => 1,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal(10.99,4),
          :created_at  => Time.now,
          :updated_at  => Time.now,
          :merchant_id => 2
          })

        a = Item.new({
          :id           => 5,
          :name         => "Water Bottles",
          :description  => "You can use it to drink things",
          :unit_price   => BigDecimal(15.99, 4),
          :created_at   => Time.now,
          :updated_at   => Time.now,
          :merchant_id  => 10
          })

          $csv = [
            {
              :id          => 1,
              :name        => "Pencil",
              :description => "You can use it to write things",
              :unit_price  => BigDecimal(10.99,4),
              :created_at  => Time.now,
              :updated_at  => Time.now,
              :merchant_id => 2
            },
              {
                  :id           => 5,
                  :name         => "Water Bottles",
                  :description  => "You can use it to drink things",
                  :unit_price   => BigDecimal(15.99, 4),
                  :created_at   => Time.now,
                  :updated_at   => Time.now,
                  :merchant_id  => 10
                  }]

      Item.add_from_csv(nil)
      p Item.all
      expect(Item.find_by_id(1)).to eq(Item.all[0])
      expect(Item.find_by_id(10)).to eq(nil)
    end

  end
end
