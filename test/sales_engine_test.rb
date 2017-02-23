require_relative 'test_helper'
#require_relative '.../black_thursday_spec_harness'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_it_exist
    se = SalesEngine.new
    assert_instance_of SalesEngine, se
  end

  # def test_for_args
  #   se = SalesEngine.new({
  # :items     => "./data/items.csv",
  # :merchants => "./data/merchants.csv"})
  # assert_equal ({:items     => "./data/items.csv",
  # :merchants => "./data/merchants.csv"}), se.items
  # end


  def test_that_it_loads_csv
    skip
    se = SalesEngine.new
    assert_equal "id,name,description,unit_price,merchant_id,created_at,updated_at", se.from_csv
  end

  def test_from_csv_accepts_key_values
    se = SalesEngine.new
    se.from_csv({:items     => "./data/items.csv", :merchants => "./data/merchants.csv"})
  end

  def test_SE_can_make_ItemRepository
    se = SalesEngine.new
    se.from_csv({:items => "./data/items.csv",
        :merchants => "./data/merchants.csv"
      })
    ir = se.items
    assert_instance_of ItemRepository, ir
  end

  def test_SE_can_make_MerchantRepository
    se = SalesEngine.new
    se.from_csv({:items => "./data/items.csv",
        :merchants => "./data/merchants.csv"
      })
    mr = se.merchants
    assert_instance_of MerchantRepository, mr
  end

  def test_that_item_passes_to_item_repo
    se = SalesEngine.new
    se.from_csv({:items => "./data/items.csv",
        :merchants => "./data/merchants.csv"
      })
    ir = se.items
    assert_instance_of CSV, ir.item_contents
  end

  def test_that_item_passes_to_merchant_repo
    se = SalesEngine.new
    se.from_csv({:items => "./data/items.csv",
        :merchants => "./data/merchants.csv"
      })
    mr = se.merchants
    assert_instance_of CSV, mr.merchant_contents
    end

  def test_that_IR_makes_items
    se = SalesEngine.new
    se.from_csv({:items => "./data/items.csv",
        :merchants => "./data/merchants.csv"
      })
    ir = se.items
    item = ir.find_by_name("Glitter scrabble frames")
    assert_instance_of Item, item
  end

  def test_that_MR_makes_merchants
    skip
    e = SalesEngine.new
    se.from_csv({:items => "./data/items.csv",
        :merchants => "./data/merchants.csv"
      })
    mr = se.merchants
    assert_instance_of CSV, mr.merchant_contents
  end
  # binding.pry


end
