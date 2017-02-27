
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/item'


class ItemTest < Minitest::Test

  attr_reader :repo, :item

  def setup
    @item = Item.new( {:id => 263395721,
                      :name => "Disney scrabble frames", :updated_at => "2008-04-02 13:48:57 UTC", :description => "Disney glitter frames\nAny colour glitter available and can do any characters you require\nDifferent colour scrabble tiles\nBlue\nBlack\nPink\nWooden", :unit_price => 1350,
                      :created_at => "2016-01-11 11:51:37 UTC", :merchant_id => 12334185 }, repo )
  end

  def test_it_creates_an_instance_of_item
    assert @item
  end

  def test_it_has_an_id
    assert_equal 263395721, @item.id
  end

  def test_it_has_a_name
    assert_equal "Disney scrabble frames", @item.name
  end

  def test_it_has_an_updated_at
    assert_equal Time , @item.updated_at.class
  end

  def test_it_has_a_description
    assert_equal "Disney glitter frames\nAny colour glitter available and can do any characters you require\nDifferent colour scrabble tiles\nBlue\nBlack\nPink\nWooden" , @item.description
  end

  def test_it_has_a_unit_price
    assert_equal BigDecimal, @item.unit_price.class
  end

  def test_it_has_a_created_at
    assert_equal Time, @item.created_at.class
  end

  def test_it_has_a_merchant_id
    assert_equal 12334185, @item.merchant_id
  end

  def test_it_has_a_price_in_dollas
    assert_equal 13.50, @item.unit_price_to_dollars(1350)
  end

end
