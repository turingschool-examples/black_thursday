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
              }
              ]

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
                  }
                  ]

      Item.add_from_csv(nil)
      Item.all
      expect(Item.find_by_id(1)).to eq(Item.all[0])
      expect(Item.find_by_id(10)).to eq(nil)
    end
    it "can find by name" do

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
                  }
                  ]

      Item.add_from_csv(nil)
      Item.all
      expect(Item.find_by_name("Pencil")).to eq([Item.all[0]])
      expect(Item.find_by_name("Imaginary")).to eq([])
    end

    it "can find by description" do

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
                  }
                  ]

      Item.add_from_csv(nil)
      Item.all
      expect(Item.find_all_with_description("You can use it to write things")).to eq([Item.all[0]])
      expect(Item.find_all_with_description("Imaginary")).to eq([])
    end

    it "can find by unit price" do

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
                  }
                  ]

      Item.add_from_csv(nil)
      Item.all
      expect(Item.find_all_by_price(BigDecimal(15.99, 4))).to eq([Item.all[1]])
      expect(Item.find_all_by_price(BigDecimal(16.99, 4))).to eq([])
    end
    xit "can find by price range" do

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
                  }
                  ]

      Item.add_from_csv(nil)
      Item.all
      expect(Item.find_all_with_description("You can use it to write things")).to eq([Item.all[0]])
      expect(Item.find_all_with_description("Imaginary")).to eq([])
    end
    it "can find by merchant_id" do

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
                  },
                  {
                  :id           => 7,
                  :name         => "Water Bottle Cage",
                  :description  => "You can use it to hold water on a bike!",
                  :unit_price   => BigDecimal(125.99, 5),
                  :created_at   => Time.now,
                  :updated_at   => Time.now,
                  :merchant_id  => 10
                  }
                  ]

      Item.add_from_csv(nil)
      Item.all
      expect(Item.find_all_by_merchant_id(10)).to eq([Item.all[1], Item.all[2]])
      expect(Item.find_all_by_merchant_id(6)).to eq([])
    end
    it "can create a new item with max_id being +1" do

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
                  },
                  {
                  :id           => 7,
                  :name         => "Water Bottle Cage",
                  :description  => "You can use it to hold water on a bike!",
                  :unit_price   => BigDecimal(125.99, 5),
                  :created_at   => Time.now,
                  :updated_at   => Time.now,
                  :merchant_id  => 10
                  }
                  ]

      Item.add_from_csv(nil)
      Item.all

      attributes = {
                    :id           => 6,
                    :name         => "Bike",
                    :description  => "You can use it to go fast",
                    :unit_price   => BigDecimal(400.99, 5),
                    :created_at   => Time.now,
                    :updated_at   => Time.now,
                    :merchant_id  => 10

                    }
      Item.create(attributes)
      Item.all
      expect((Item.all).length).to eq(4)
      expect(Item.all[3].id).to eq(8)
    end


  end
end
