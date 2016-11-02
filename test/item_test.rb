require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/item_repo'

class ItemTest < Minitest::Test

  def test_it_exists
    assert_instance_of Item.new(data,repo)
  end

  def test_it_has_a_class
    skip
    i = Item.new({:id => "Blue purse"})
    assert_equal Item, i.class
  end

  def test_it_has_an_id
    skip
    i = Item.new({:id => "263567474"})
    assert_equal "263567474", i.id
  end

  def test_it_has_a_name
    skip
    i = Item.new({:name => "Minty Green Knit Crochet Infinity Scarf"})
    assert_equal "Minty Green Knit Crochet Infinity Scarf", i.name
  end

  def test_it_has_a_description
    skip
    i = Item.new(:description => "- Super Chunky knit infinity scarf
- Soft mixture of 97% Acrylic and 3% Viscose
- Beautiful, Warm, and Stylish
- Very easy to care for

Hand wash with cold water and lay flat to dry")

    assert_equal "- Super Chunky knit infinity scarf
- Soft mixture of 97% Acrylic and 3% Viscose
- Beautiful, Warm, and Stylish
- Very easy to care for

Hand wash with cold water and lay flat to dry", i.description
  end

  def test_it_has_a_unit_price
    skip
    i = Item.new(:unit_price)
    assert_equal "3800", i.unit_price
  end

  def test_it_has_a_merchant_id
    skip
    i = Item.new(:merchant_id)
    assert_equal "12334871", i.merchant_id
  end

  def test_it_displays_when_it_was_created
    skip
    i = Item.new(:created_at)
    assert_equal "2016-01-11 20:59:20 UTC", i.created_at
  end

  def test_it_displays_when_it_was_updated
    skip
    i = Item.new(:updated_at)
    assert_equal "2009-12-09 12:08:04 UTC", i.updated_at
  end

  def test_it_has_a_unit_price_to_dollars
    skip
    i = Item.new(:unit_price)
    assert_equal 3800.0, i.unit_price_to_dollars
  end

end
