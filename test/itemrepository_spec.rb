require './lib/item'
require './lib/itemrepository'
require 'bigdecimal'
require 'bigdecimal/util'
require 'objspace'
require './lib/sales_engine'

RSpec.describe ItemRepository do


    it "can return the price of item in dollars (float)" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      item1 = ir.find_by_id("263395617")
      require "pry"; binding.pry
      expect(item1.unit_price_to_dollars).to eq(1300)
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

      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      item1 = ir.find_by_id("263395721")

      i = Item.new({
        :id          => 263395721,
        :name        => "Disney scrabble frames",
        :description => "Disney glitter frames \n\nAny colour glitter available and can do any characters you require \n\nDifferent colour scrabble tiles\n\nBlue\nBlack\nPink\nWooden",
        :unit_price  => BigDecimal(1350,4),
        :created_at  => "2016-01-11 11:51:37 UTC",
        :updated_at  => "2008-04-02 13:48:57 UTC",
        :merchant_id => 12334185
        })

      expect(item1).to eq(i)


    end
    xit "can find by name" do

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

    xit "can find by description" do

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

    xit "can find by unit price" do

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
      expect(Item.find_all_by_price_in_range(BigDecimal(5.99, 4), BigDecimal(14.99, 4))).to eq([Item.all[0]])
      expect(Item.find_all_by_price_in_range(BigDecimal(75.99, 4), BigDecimal(95.99, 4))).to eq([])

    end
    xit "can find by merchant_id" do

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
    xit "can create a new item with max_id being +1" do

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

    xit "can update id and attributes" do
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

    Item.all

    results =   {
      :id           => 5,
      :name         => "Bike",
      :description  => "You can use it to go fast",
      :unit_price   => BigDecimal(400.99, 5),
      :created_at   => Time.now,
      :updated_at   => Time.now,
      :merchant_id  => 10
      }


    expect(Item.update(5, attributes)).to eq(results)

  end

  xit "can delete by id" do
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
        Item.delete(7)
        expect(Item.all.length).to eq(2)

    end

  end
