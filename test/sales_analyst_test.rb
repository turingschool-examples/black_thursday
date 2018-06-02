require './test/test_helper.rb'
require './lib/sales_analyst.rb'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      # :invoices  => "./data/invoices_test.csv",
      :invoices => "./data/invoices.csv",
      :customers => "./data/customers.csv",
      # :invoice_items => "./data/invoice_items_test.csv",
      :invoice_items => "./data/invoice_items.csv",
      # :transactions => "./data/transactions_test.csv"
      :transactions => "./data/transactions.csv"
      })
    merchants = se.load_file(se.content[:merchants])
    items = se.load_file(se.content[:items])
    invoices = se.load_file(se.content[:invoices])
    customers = se.load_file(se.content[:customers])
    invoice_items = se.load_file(se.content[:invoice_items])
    transactions = se.load_file(se.content[:transactions])
    @mr = MerchantRepository.new(merchants)
    @ir = ItemRepository.new(items)
    @in = InvoiceRepository.new(invoices)
    @cr = CustomerRepository.new(customers)
    @iir = InvoiceItemRepository.new(invoice_items)
    @tr = TransactionRepository.new(transactions)
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    skip
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_find_the_items_per_merchant
    skip
    first_id = @ir.all[0].merchant_id
    second_id = @ir.all[1].merchant_id
    assert_equal 1, @sa.items_per_merchant[0]
    assert_equal 6, @sa.items_per_merchant[1]
  end

  def test_analyst_can_check_average_items_per_merchant
    skip
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_can_find_the_standard_deviation_for_average_items_per_merchant
    skip
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_merchants_offering_high_item_count
    skip
    assert_equal 52, @sa.merchants_with_high_item_count.length
    assert_instance_of Merchant, @sa.merchants_with_high_item_count.first
  end

  def test_it_can_find_average_item_price_per_merchant
    skip
    merchant_id = 12334105
    assert_equal 16.66, @sa.average_item_price_for_merchant(12334105)
  end

  def test_it_can_find_average_average_item_price_per_merchant
    skip
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_it_can_find_the_price_standard_deviation
    skip
    assert_equal 2900.99, @sa.item_price_standard_deviation
  end

  def test_it_can_find_all_golden_items
    skip
    assert_equal 5, @sa.golden_items.length
    assert_equal Item, @sa.golden_items.first.class
  end

  def test_it_can_find_the_invoices_per_merchant
    skip
    first_id = @in.all[0].merchant_id
    second_id = @in.all[1].merchant_id
    assert_equal 1, @sa.invoices_per_merchant[0]
    assert_equal 1, @sa.invoices_per_merchant[1]
  end

  def test_it_can_find_the_average_invoices_per_merchant
    skip
    assert_equal 1.09, @sa.average_invoices_per_merchant
  end

  def test_it_can_find_the_average_invoices_per_merchant_standard_devaition
    skip
    assert_equal 0.28, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_top_performing_merchants
    skip
    assert_equal 4, @sa.top_merchants_by_invoice_count.count
    assert_instance_of Merchant, @sa.top_merchants_by_invoice_count[0]
  end

  def test_it_can_find_bottom_performing_merchants
    skip
    assert_equal 0, @sa.bottom_merchants_by_invoice_count.count
    # assert_instance_of Merchant, @sa.bottom_merchants_by_invoice_count[0]
  end

  def test_it_can_find_top_days_of_the_week
    skip
    assert_equal 1, @sa.top_days_by_invoice_count.count
    assert_equal "Friday", @sa.top_days_by_invoice_count.first
  end

  def test_it_can_find_the_percent_of_invoices_at_each_status
    skip
    assert_equal 34.0, @sa.invoice_status(:pending)
    assert_equal 60.0, @sa.invoice_status(:shipped)
    assert_equal 6.0, @sa.invoice_status(:returned)
  end

  def test_it_can_check_if_an_invoice_is_fully_paid
    skip
    assert @sa.invoice_paid_in_full?(46)
    assert @sa.invoice_paid_in_full?(2179)
    refute @sa.invoice_paid_in_full?(1752)
    # refute @sa.invoice_paid_in_full?(204)
  end

  def test_it_can_return_the_amount_for_any_invoice
    skip
    assert_equal 21067.77, @sa.invoice_total(1)
  end

  def test_it_can_find_the_total_revenue_by_date
    skip
    date = Time.parse("2009-02-07")
    assert_equal 21067.77, @sa.total_revenue_by_date(date)
    assert_instance_of BigDecimal, @sa.total_revenue_by_date(date)
  end

  def test_it_can_find_top_x_revenue_earners
    top_earners = @sa.top_revenue_earners(10)
    assert_equal 10, top_earners.length
    assert_equal Merchant, top_earners.first.class
    assert_equal 12334634, top_earners.first.id
    assert_equal 12335747, top_earners.last.id
  end
end
