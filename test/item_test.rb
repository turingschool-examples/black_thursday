gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'


class ItemTest < MiniTest::Test
    def setup
      @item1 = Item.new({:id          => "1",
                         :name        => "Darcy - Day at the Spa",
                         :description => "Hand Wicked and Hand Poured, Small Batch Candles.",
                         :unit_price  => "795",
                         :created_at  => "2016-01-11 17:12:39 UTC",
                         :updated_at  => "1998-12-18 19:32:09 UTC",
                         :merchant_id => "12334727"}, self)
    end

    def test_it_holds_id
      assert_equal 1, @item1.id
    end

    def test_it_holds_returns_only_integers
      assert_equal 1, @item1.id
    end

    def test_it_holds_a_name
      assert_equal "Darcy - Day at the Spa", @item1.name
    end

    def test_it_holds_description
      assert_equal "Hand Wicked and Hand Poured, Small Batch Candles.", @item1.description
    end

    def test_it_holds_unit_price
      assert_instance_of BigDecimal, @item1.unit_price
    end

    def test_it_holds_created_at
      assert_equal true, @item1.created_at.is_a?(Time)
    end

    def test_it_holds_updated_at
      assert_equal true, @item1.updated_at.is_a?(Time)
    end

    def test_it_holds_merchant_id
      assert_equal 12334727, @item1.merchant_id
    end

    def test_it_returns_self
      assert_equal true, @item1.parent.is_a?(ItemTest)
    end

    def test_returns_unit_price_to_dollars
      assert_equal 7.95, @item1.unit_price_to_dollars
    end



end
