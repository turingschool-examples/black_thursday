require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    sales = SalesEngine.new([], [])

    assert_instance_of SalesEngine, sales
  end

  def test_it_can_make_merchant_repo_instance
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_can_make_item_repo_instance
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    assert_instance_of ItemRepository, se.items
  end

  def test_that_merchant_repo_contains_merchants
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    refute_equal 0, se.merchants.all.size

  end

  def test_that_item_repo_contains_items
    skip
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    refute_equal 0, se.items.all.size
  end

  def test_that_sales_engine_can_pass_info
    @merchant_1 = Merchant.new({id: 5, name: 'Steve'})
    @merchant_2 = Merchant.new({id: 10, name: 'Turing School'})
    @merchant_3 = Merchant.new({id: 7, name: 'Turk'})
    @merchants = [@merchant_1, @merchant_2, @merchant_3]

    @item_1 = Item.new({
              :id          => 1,
              :name        => "Pencil",
              :description => "You can use it to write things",
              :unit_price  => BigDecimal.new(10.99,4),
              :created_at  => @time,
              :updated_at  => @time,
              :merchant_id => 2
            })

    @item_2 = Item.new({
              :id          => 2,
              :name        => "Pen",
              :description => "You can use it to write things in ink!",
              :unit_price  => BigDecimal.new(32.99,4),
              :created_at  => Time.now,
              :updated_at  => Time.now,
              :merchant_id => 3
            })
    @items = [@item_1, @item_2]


    se = SalesEngine.from_csv({
    :items     => @items,
    :merchants => @merchants,
    })

    assert_equal @merchants, se.merchants.all
    assert_equal @items, se.items.all
  end


end
