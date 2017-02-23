require_relative 'test_helper.rb'
require_relative '../lib/item'

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
    i = Item.new({:created_at => Time.now})

    assert Time.now <=> i.created_at
  end

  def test_it_knows_what_time_it_was_udpated
    i = Item.new({:updated_at => Time.now})

    assert Time.now <=> i.updated_at
  end

  def test_it_knows_merchant_id
    i = Item.new({:merchant_id => "123456"})

    assert_equal "123456", i.merchant_id
  end

  def test_it_can_conververt_unit_price_to_dollars
    i = Item.new({:unit_price => BigDecimal.new(10.99,4)})

    assert_equal 10.99, i.unit_price_to_dollars
  end
end
