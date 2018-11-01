require './lib/sales_engine'
require_relative 'test_helper'
require_relative 'test_data'

class CustomerIntelligenceTest < Minitest::Test
  include TestData
  def setup
    make_repositories
    se = SalesEngine.new(@itemr,@mr,@ir,@iir,@cr,@tr)
    @sa = se.analyst
  end

  def test_it_finds_top_buyers
    make_top_buyers_test_data

    expected = [@customer_3, @customer_2, @customer_1]
    result = @sa.top_buyers

    assert_equal expected, result
  end

  def test_it_finds_one_time_buyers
    make_one_time_buyers_test_data

    assert_equal [@customer_1], @sa.one_time_buyers
  end

  def test_it_finds_one_time_buyers_top_item
    make_one_time_buyers_top_item_test_data

    assert_equal @item_1, @sa.one_time_buyers_top_item
  end

  def test_it_finds_top_merchant_for_customer
    make_top_merchant_and_invoice_items_test_data

    assert_equal @m, @sa.top_merchant_for_customer(@customer_1.id)
  end

  def test_it_finds_invoice_with_most_items_from_customer
    make_top_merchant_and_invoice_items_test_data

    assert_equal @inv_1, @sa.find_invoice_with_most_items_from(@customer_1)
  end
end
