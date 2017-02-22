require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/items'

class ItemsTest < Minitest::Test

  def test_it_gets_items_csv

    #assert_instance_of CSV,
  end

  def test_it_gets_the_id

    #assert_equal integer,
  end

  def test_it_gets_the_name

    #assert_equal "name",
  end

  def test_it_gets_the_description

    #assert_equal "description"
  end

  def test_it_gets_the_unit_price

    #assert_equal BigDecimal
  end

  def test_it_was_created_at

    #assert_instance_of Time,
  end

  def test_it_was_updated_at

    #assert_instance_of Time,
  end

  def test_it_gets_the_merchant_id

    #assert_equal integer,
  end

  def test_it_converts_unit_price_to_dollars

    #assert_equal float, dollar amount $$.$$
  end

end
