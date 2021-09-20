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

      item1 = ir.find_by_id(263395617)
      #require "pry"; binding.pry
      expect(item1.unit_price_to_dollars).to eq(13.00)
    end

    it "can return an array of all know Item instances" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      expect(ir.all.length).to eq(1367)
    end

    it "can find by id" do

      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      item1 = ir.find_by_id(263395721)

      i = Item.new({
        :id          => 263395721,
        :name        => "Disney scrabble frames",
        :description => item1.description,
        :unit_price  => BigDecimal(1350,4),
        :created_at  => "2016-01-11 11:51:37 UTC",
        :updated_at  => "2008-04-02 13:48:57 UTC",
        :merchant_id => 12334185
        })
      expect(item1.id).to eq(i.id)


    end
    it "can find by name" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      item1 = ir.find_by_name("Disney scrabble frames")

      i = Item.new({
        :id          => 263395721,
        :name        => "Disney scrabble frames",
        :description => item1.description,
        :unit_price  => BigDecimal(1350,4),
        :created_at  => "2016-01-11 11:51:37 UTC",
        :updated_at  => "2008-04-02 13:48:57 UTC",
        :merchant_id => 12334185
        })
      expect(item1.id).to eq(i.id)
    end

    it "can find by description" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      item1 = ir.find_by_name("Disney scrabble frames")

      i = Item.new({
        :id          => 263395721,
        :name        => "Disney scrabble frames",
        :description => item1.description,
        :unit_price  => BigDecimal(1350,4),
        :created_at  => "2016-01-11 11:51:37 UTC",
        :updated_at  => "2008-04-02 13:48:57 UTC",
        :merchant_id => 12334185
        })
      expect((ir.find_all_with_description(item1.description)).length).to eq(1)
    end

    it "can find by unit price" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      item1 = ir.find_by_name("Disney scrabble frames")

      i = Item.new({
        :id          => 263395721,
        :name        => "Disney scrabble frames",
        :description => item1.description,
        :unit_price  => BigDecimal(1350,4),
        :created_at  => "2016-01-11 11:51:37 UTC",
        :updated_at  => "2008-04-02 13:48:57 UTC",
        :merchant_id => 12334185
        })
      expect(ir.find_all_by_price(BigDecimal(13.50,4)).length).to eq(1)
    end
    it "can find by price range" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      item1 = ir.find_by_name("Disney scrabble frames")

      i = Item.new({
        :id          => 263395721,
        :name        => "Disney scrabble frames",
        :description => item1.description,
        :unit_price  => BigDecimal(1350,4),
        :created_at  => "2016-01-11 11:51:37 UTC",
        :updated_at  => "2008-04-02 13:48:57 UTC",
        :merchant_id => 12334185
        })
      expect(ir.find_all_by_price_in_range(13.50, 13.50).length).to eq(1)

    end
    it "can find by merchant_id" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      item1 = ir.find_by_name("Disney scrabble frames")

      i = Item.new({
        :id          => 263395721,
        :name        => "Disney scrabble frames",
        :description => item1.description,
        :unit_price  => BigDecimal(1350,4),
        :created_at  => "2016-01-11 11:51:37 UTC",
        :updated_at  => "2008-04-02 13:48:57 UTC",
        :merchant_id => 12334185
        })
      expect(ir.find_all_by_merchant_id(12334185).length).to eq(6)
    end
    it "can create a new item with max_id being +1" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      item1 = ir.find_by_name("Disney scrabble frames")

      i = Item.new({
        :id          => 263395721,
        :name        => "Disney scrabble frames",
        :description => item1.description,
        :unit_price  => BigDecimal(1350,4),
        :created_at  => "2016-01-11 11:51:37 UTC",
        :updated_at  => "2008-04-02 13:48:57 UTC",
        :merchant_id => 12334185
        })

        attributes = {
                      :id           => 6,
                      :name         => "Bike",
                      :description  => "You can use it to go fast",
                      :unit_price   => BigDecimal(400.99, 5),
                      :created_at   => Time.now,
                      :updated_at   => Time.now,
                      :merchant_id  => 10

                      }

      expect(ir.all.length).to eq(1367)
      ir.create(attributes)
      expect(ir.all.length).to eq(1368)

    end

    it "can update id and attributes" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      item1 = ir.find_by_name("Disney scrabble frames")

      i = Item.new({
        :id          => 263395721,
        :name        => "Disney scrabble frames",
        :description => item1.description,
        :unit_price  => BigDecimal(1350,4),
        :created_at  => "2016-01-11 11:51:37 UTC",
        :updated_at  => "2008-04-02 13:48:57 UTC",
        :merchant_id => 12334185
        })

        attributes = {
                      :id           => 6,
                      :name         => "Bike",
                      :description  => "You can use it to go fast",
                      :unit_price   => BigDecimal(400.99, 5),
                      :created_at   => Time.now,
                      :updated_at   => Time.now,
                      :merchant_id  => 10

                      }

    results =   {
      :id           => 263395721,
      :name         => "Bike",
      :description  => "You can use it to go fast",
      :unit_price   => BigDecimal(40099.0, 5),
      :created_at   => "2016-01-11 11:51:37 UTC",
      :updated_at   => "2008-04-02 13:48:57 UTC",
      :merchant_id  => 12334185
      }

    item_results = Item.new(results)
    expect((ir.update(263395721, attributes)).name).to eq(item_results.name)
    expect((ir.update(263395721, attributes)).id).to eq(item_results.id)
    expect((ir.update(263395721, attributes)).description).to eq(item_results.description)
    expect((ir.update(263395721, attributes)).unit_price).to eq(item_results.unit_price)


  end

  it "can delete by id" do


    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    ir = se.items

    item1 = ir.find_by_name("Disney scrabble frames")

    i = Item.new({
      :id          => 263395721,
      :name        => "Disney scrabble frames",
      :description => item1.description,
      :unit_price  => BigDecimal(1350,4),
      :created_at  => "2016-01-11 11:51:37 UTC",
      :updated_at  => "2008-04-02 13:48:57 UTC",
      :merchant_id => 12334185
      })

      attributes = {
                    :id           => 6,
                    :name         => "Bike",
                    :description  => "You can use it to go fast",
                    :unit_price   => BigDecimal(400.99, 5),
                    :created_at   => Time.now,
                    :updated_at   => Time.now,
                    :merchant_id  => 10

                    }

    results =   {
      :id           => 263395721,
      :name         => "Bike",
      :description  => "You can use it to go fast",
      :unit_price   => BigDecimal(400.99, 5),
      :created_at   => "2016-01-11 11:51:37 UTC",
      :updated_at   => "2008-04-02 13:48:57 UTC",
      :merchant_id  => 12334185
      }

    item_results = Item.new(results)
    expect(ir.delete(263395721).length).to eq(1366)
    end

  end
