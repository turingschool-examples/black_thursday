require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/item_repo'
class ItemTest < Minitest::Test
  attr_reader :data,
              :repo
  def setup
    @data = {:id => "263567474",
             :name => "Minty Green Knit Crochet Infinity Scarf",
             :description => "- Super Chunky knit infinity scarf - Soft mixture of 97% Acrylic and 3% Viscose - Beautiful, Warm, and Stylish - Very easy to care for Hand wash with cold water and lay flat to dry",
             :unit_price => 3800,
             :merchant_id => "12334871",
             :created_at => "2016-01-11 20:59:20 UTC",
             :updated_at => "2009-12-09 12:08:04 UTC"}
    @repo = Minitest::Mock.new
  end
  def test_it_exists
    assert Item.new(data, repo)
  end
  def test_it_has_a_class
    i = Item.new(data, repo)
    assert_equal Item, i.class
  end
  def test_it_has_an_id
    i = Item.new(data, repo)
    assert_equal 263567474, i.id
  end
  def test_it_has_a_name
    i = Item.new(data, repo)
    assert_equal "Minty Green Knit Crochet Infinity Scarf", i.name
  end
  def test_it_has_a_description
    i = Item.new(data, repo)
    assert_equal "- Super Chunky knit infinity scarf - Soft mixture of 97% Acrylic and 3% Viscose - Beautiful, Warm, and Stylish - Very easy to care for Hand wash with cold water and lay flat to dry", i.description
  end
  def test_it_has_a_unit_price
    i = Item.new(data, repo)
    assert_equal 3800, i.unit_price
  end
  def test_it_has_a_merchant_id
    i = Item.new(data, repo)
    assert_equal "12334871", i.merchant_id
  end
  def test_it_displays_when_it_was_created
    i = Item.new(data, repo)
    assert_equal "2016-01-11 20:59:20 UTC", i.created_at
  end
  def test_it_displays_when_it_was_updated
    i = Item.new(data, repo)
    assert_equal "2009-12-09 12:08:04 UTC", i.updated_at
  end
  def test_it_has_a_unit_price_to_dollars
    i = Item.new(data, repo)
    assert_equal 3800.0, i.unit_price_to_dollars
  end
end