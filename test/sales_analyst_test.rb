require_relative "test_helper"
require_relative "../lib/sales_analyst"

class SalesAnalystTest < Minitest::Test

  def test_it_exist
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)
    
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_find_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 4.33, sa.average_items_per_merchant
  end

  def test_it_can_find_merchant_list
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)
    
    assert_equal 15, sa.merchant_list.count
    assert_equal 12334105, sa.merchant_list.first
    assert_equal 12334160, sa.merchant_list.last
  end

  def test_it_can_find_number_of_items_merchant_sells
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 15, sa.find_items.count
    assert_equal 3, sa.find_items.first
    assert_equal 23, sa.find_items[4]
    assert_equal 1, sa.find_items.last
  end

  def test_it_can_find_standard_deviation_difference_total
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 488.99, sa.find_standard_dev_difference_total
  end

  def test_it_can_find_standard_deviation_total
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 34.93, sa.total_std_dev_sum_minus_one.round(2)
  end

  
end





































