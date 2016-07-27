gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'


class ItemTest < MiniTest::Test
    def setup
      @item = Item.new({:id => 1,
                         :name        => "Pencil",
                         :description => "It's a pencil",
                         :unit_price  => BigDecimal.new(10.99,4),
                         :created_at  => Time.now,
                         :updated_at  => Time.now,
                         :merchant_id => 1234567}, "repo")
    end

    def test_it_holds_id
      assert_equal 1, @item.id
    end

    def test_it_holds_a_name
      assert_equal "Pencil", @item.name
    end

    def test_it_holds_description
      assert_equal "It's a pencil", @item.description
    end

    def test_it_holds_unit_price
      assert_equal true, @item.unit_price.is_a?(BigDecimal)
    end

    def test_it_holds_created_at
      assert_equal true, @item.created_at.is_a?(Time)
    end

    def test_it_holds_updated_at
      assert_equal true, @item.updated_at.is_a?(Time)
    end

    def test_it_holds_merchant_id
      assert_equal 1234567, @item.merchant_id
    end

    def test_it_holds_repo
      assert_equal "repo", @item.repo
    end

    def test_returns_unit_price_to_dollars
      assert_equal 10.99, @item.unit_price_to_dollars
    end



end
