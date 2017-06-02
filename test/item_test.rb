require 'pry'

require 'bigdecimal'
require 'time'
require_relative './test_helper'
require_relative '../lib/item'
require_relative '../lib/sales_engine'


class ItemTest < MiniTest::Test

  def setup
    @files = {:items => './test/data/items_test.csv',
              :merchants => './test/data/merchants_test.csv'}

    @i1 = Item.new({"id"       => '1',
                  "merchant_id" => '11',
                  "name"        => "Pencil",
                  "description" => "You can use it to write things",
                  "unit_price"  => '1099',
                  "created_at"  => '1993-09-29 11:56:40 UTC',
                  "updated_at"  => '1993-09-29 11:56:40 UTC'
                 })

    @i2 = Item.new({"id"         => '2',
                  "merchant_id" => '12',
                  "name"        => "Pen",
                  "description" => "You can use it to write things",
                  "unit_price"  => '1199',
                  "created_at"  => '1993-09-29 11:56:40 UTC',
                  "updated_at"  => '1993-09-29 11:56:40 UTC'
                 })

  end

  def test_if_create_class

    assert_instance_of Item, @i1
  end

  def test_default_attributes_and_format

    assert_equal 1, @i1.id
    assert_equal 11, @i1.merchant_id
    assert_equal "Pencil", @i1.name
    assert_equal "You can use it to write things", @i1.description
    assert_equal 0.1099E4, @i1.unit_price
    assert @i1.created_at
    assert @i1.updated_at
  end

  def test_merchant_method_returns_merchants
    se = SalesEngine.from_csv(@files)
    item = se.items.find_by_id(263396209)
    actual = item.merchant
    
    assert_instance_of Merchant, actual
  end
end
