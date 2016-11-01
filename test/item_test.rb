require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test

  def test_it_exists
    assert Item.new({:name =>"Blue purse"})
  end

  def test_it_has_a_class
    i = Item.new({:id => "Blue purse"})
    assert_equal Item, i.class
  end

  def test_it_has_an_id
    i = Item.new({:id => "263567474"})
    assert_equal "263567474", i.id
  end

  def test_it_has_a_name
    i = Item.new({:name => "Minty Green Knit Crochet Infinity Scarf"})
    assert_equal "Minty Green Knit Crochet Infinity Scarf", i.name
  end

  def test_it_has_a_description
    i = Item.new(:description)
    description = "- Super Chunky knit infinity scarf
- Soft mixture of 97% Acrylic and 3% Viscose
- Beautiful, Warm, and Stylish
- Very easy to care for

Hand wash with cold water and lay flat to dry"
    assert_equal description, i.description
  end

  def test_it_has_a_unit_price
    i = Item.new(:unit_price)
    assert_equal "3800", i.unit_price
  end

  def test_it_has_a_merchant_id
    i = Item.new(:merchant_id)
    assert_equal "12334871", i.merchant_id
  end

  def test_it_displays_when_it_was_created
    i = Item.new(:created_at)
    assert_equal "2016-01-11 20:59:20 UTC", i.created_at
  end

  def test_it_displays_when_it_was_updated
    i = Item.new(:updated_at)
    assert_equal "2009-12-09 12:08:04 UTC", i.updated_at
  end

  def test_it_has_a_unit_price_to_dollars
    i = Item.new(:unit_price)
    assert_equal 3800.0, i.unit_price_to_dollars
  end

end
