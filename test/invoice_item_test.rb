gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require 'bigdecimal'

""	"263519844"	"1"	"5"	"13635"	"2012-03-27 14:54:09 UTC"	"2012-03-27 14:54:09 UTC"

class ItemTest < MiniTest::Test
    def setup
      @first_item = InvoiceItem.new({:id          => "1",
                              :item_id     => "263519844",
                              :invoice_id  =>"1",
                              :quantity    => "5",
                              :unit_price  => "13635",
                              :created_at  => "012-03-27 14:54:09 UTC",
                              :updated_at  => "2012-03-27 14:54:09 UTC",
                              }, self)
    end

    def test_it_holds_id
      assert_equal 1, @first_item.id
    end

    def test_it_holds_returns_only_integers
      assert_equal 1, @first_item.id
    end

    def test_it_holds_a_item_id
      assert_equal 263519844, @first_item.item_id
    end

    def test_it_holds_quantity
      assert_equal 5, @first_item.quantity
    end

    def test_it_holds_unit_price
      assert_instance_of BigDecimal, @first_item.unit_price
    end

    def test_it_holds_created_at
      assert_equal true, @first_item.created_at.is_a?(Time)
    end

    def test_it_holds_updated_at
      assert_equal true, @first_item.updated_at.is_a?(Time)
    end

    def test_it_returns_self
      assert_equal true, @first_item.parent.is_a?(ItemTest)
    end

    def test_returns_unit_price_to_dollars
      assert_instance_of BigDecimal, @first_item.unit_price_to_dollars
    end

end
