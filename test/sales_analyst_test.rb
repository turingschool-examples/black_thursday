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

  def test_it_can_find_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 5.91, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_create_merchant_id_item_total_list_in_a_hash
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert Hash, sa.merchants_by_item_count
    assert_equal 15, sa.merchants_by_item_count.count
    assert_equal 12334105, sa.merchants_by_item_count.first.first
    assert_equal 3, sa.merchants_by_item_count[12334105]
  end

  def test_it_can_find_standard_deviation_plus_average
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 10.24, sa.standard_dev_plus_average
  end

  def test_it_can_filter_merchants_by_items_in_stock_in_array
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert Array, sa.merchants_by_items_in_stock
    assert_equal 12334123, sa.merchants_by_items_in_stock.first.first
    assert_equal 23, sa.merchants_by_items_in_stock.first.last
    assert_equal 12334123, sa.merchants_by_items_in_stock.last.first
    assert_equal 23, sa.merchants_by_items_in_stock.last.last
  end

  def test_it_can_find_merchants_with_high_item_count
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 1, sa.merchants_with_high_item_count.count
    assert_equal 12334123, sa.merchants_with_high_item_count.first.id
  end

  def test_it_can_find_all_merchant_items
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 3, sa.all_merchant_items(12334105).count
  end

  def test_it_can_find_average_item_price_for_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 9.99, sa.average_item_price_for_merchant(12334105)
  end

  def test_it_can_find_average_average_price_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 35.77, sa.average_average_price_per_merchant
  end

  def test_it_can_find_average_unit_price
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 55.21, sa.average_unit_price
  end

  def test_it_can_find_unit_price_and_average_difference_squared_sum
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 126898.96, sa.unit_price_and_average_sqr_sum.round(2)
  end

  def test_the_unit_price_standard_deviation_sum_minus_one
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 1982.8, sa.unit_price_std_dev_sum_minus_one.round(2)
  end

  def test_it_can_find_unit_price_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 44.53, sa.unit_price_stnd_dev
  end

  def test_it_can_find_golden_items_deviation
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 144.27, sa.golden_items_stnd_dev
  end

  def test_it_can_find_golden_items
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 6, sa.golden_items.count
    assert_equal 263400121, sa.golden_items.first.id
    assert_equal 12334113, sa.golden_items.first.merchant_id
  end

  def test_it_can_find_average_invoices_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 10.8, sa.average_invoices_per_merchant
  end

end




















