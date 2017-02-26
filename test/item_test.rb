require_relative 'test_helper.rb'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test
  def test_it_exists
    i = Item.new

    assert_instance_of Item, i
  end

  def test_it_knows_id
    i = Item.new({:id => 5})
    assert_equal 5, i.id
  end

  def test_it_knows_name
    i = Item.new({:name => "Turing"})
    assert_equal "Turing", i.name
  end

  def test_it_returns_description
    i = Item.new({:description => "You can use it to write things"})

    assert_equal "You can use it to write things", i.description
  end

  def test_it_knows_unit_price
    i = Item.new({:unit_price => BigDecimal.new(10.99,4)})

    assert_instance_of BigDecimal, i.unit_price
  end

  def test_it_knows_what_time_it_was_created
    i = Item.new({:created_at => "2007-06-04 21:35:10 UTC"})

    assert_instance_of Time, i.created_at
    assert_equal 2007, i.created_at.year
  end

  def test_it_knows_what_time_it_was_udpated
    i = Item.new({:updated_at => "2016-01-11 09:34:06 UTC"})

    assert_instance_of Time, i.updated_at
    assert_equal 2016, i.updated_at.year
  end

  def test_it_knows_merchant_id
    i = Item.new({:merchant_id => 123456})

    assert_equal 123456, i.merchant_id
  end

  def test_it_converts_unit_price_to_bigdecimal
    i = Item.new({:unit_price => "1099"})

    assert_instance_of BigDecimal, i.unit_price
  end

  def test_it_can_convert_unit_price_to_dollars
    i = Item.new({:unit_price => "1099"})

    assert_equal 10.99, i.unit_price_to_dollars
  end
  
  
  def test_it_can_find_merchant_from_merchant_id
    se = SalesEngine.from_csv({
        :merchants     => "./test/fixtures/temp_merchants.csv",
        :items     => "./test/fixtures/temp_items.csv",
        :invoices => "./test/fixtures/invoices_truncated.csv"
        })
    item = se.items.find_by_id(263395617)
    
    assert_instance_of Merchant, item.merchant
    assert_equal "HEYhey", item.merchant.name
  end
end
