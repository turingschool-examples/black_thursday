require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    data = {
      items:         './test/fixtures/items_sample.csv',
      merchants:     './test/fixtures/merchants_sample.csv',
      invoices:      './test/fixtures/invoices_sample.csv',
      invoice_items: './test/fixtures/invoice_items_sample.csv',
      transactions:  './test/fixtures/transactions_sample.csv',
      customers:     './test/fixtures/customers_sample.csv'
    }
    @se = SalesEngine.new(data)
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_mean_finder
    items = [3, 4, 5, 6, 2, 7, 1]
    assert_equal 4, @sales_analyst.mean_finder(items)
  end

  def test_standard_deviation
    items = [3, 4, 5, 6, 2, 7, 1]
    assert_equal 2.16, @sales_analyst.standard_devation(4, items).round(2)
  end

  def test_average_items_per_merchant
    assert_equal 2.63, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    std_dev = @sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal 3.16, std_dev
  end

  def test_item_count_per_merchant
    expected = [1, 3, 1, 10, 2, 3, 1, 0]

    assert_equal expected, @sales_analyst.items_count_per_merchant
  end

  def test_merchants_with_high_item_count
    expected = [@se.find_merchant_by_merchant_id(12_334_195)]

    assert_equal expected, @sales_analyst.merchants_with_high_item_count
  end

  def test_avg_item_price_for_merchant
    price = @sales_analyst.average_item_price_for_merchant(12_334_185)

    assert_equal 0.1117e2, price
  end

  def test_avg_avg_price_for_merchant
    assert_equal 0.13847e3, @sales_analyst.average_average_price_per_merchant
  end

  def test_golden_items
    golden = @sales_analyst.golden_items.map(&:id)
    expected = []

    assert_equal expected, golden
  end

  def test_average_invoices_per_merchant
    assert_equal 2.0, @sales_analyst.average_invoices_per_merchant
  end

  def test_invoice_count_per_merchant
    expected = [9, 2, 1, 1, 1, 1, 1, 0]

    assert_equal expected, @sales_analyst.invoice_count_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    std_dev = @sales_analyst.average_invoices_per_merchant_standard_deviation

    assert_equal 2.88, std_dev
  end

  def test_top_merchants_by_invoice_count
    merchants = @sales_analyst.top_merchants_by_invoice_count

    assert_equal [@se.find_merchant_by_merchant_id(12_334_141)], merchants
  end

  def test_bottom_merchants_by_invoice_count
    merchants = @sales_analyst.bottom_merchants_by_invoice_count

    assert_equal [], merchants
  end

  def test_top_days_by_invoice_count
    top = @sales_analyst.top_days_by_invoice_count

    assert_equal %w[Tuesday Friday], top
  end

  def test_invoice_days
    expected = { 'Monday' => 1, 'Tuesday' => 6, 'Wednesday' => 2,
                 'Thursday' => 2, 'Friday' => 7, 'Saturday' => 1,
                 'Sunday' => 1 }

    assert_equal expected, @sales_analyst.invoice_days
  end

  def test_invoice_status
    pending = @sales_analyst.invoice_status(:pending)
    shipped = @sales_analyst.invoice_status(:shipped)
    returned = @sales_analyst.invoice_status(:returned)

    assert_equal 15.00, pending
    assert_equal 65.00, shipped
    assert_equal 20.00, returned
  end

  def test_total_revenue_by_date
    date = Date.new(2003, 3, 28)
    revenue = @sales_analyst.total_revenue_by_date(date)

    assert_equal BigDecimal.new('8590.12'), revenue
  end

  def test_compute_total_amount
    date = Date.new(2003, 3, 28)
    invoices = @se.invoices.all.find_all do |invoice|
      invoice.created_at.year == date.year && \
        invoice.created_at.mon == date.mon && \
        invoice.created_at.mday == date.mday
    end
    invoices.map! do |invoice|
      @se.invoice_items.find_all_by_invoice_id(invoice.id)
    end
    result = @sales_analyst.compute_total_amount(invoices)

    assert_equal BigDecimal.new('8590.12'), result
  end

  def test_merchants_with_pending_invoices
    @sales_analyst.merchants_with_pending_invoices do |merchant|
      assert_instance_of Merchant, merchant
    end
    pending = @sales_analyst.merchants_with_pending_invoices.length
    first = @sales_analyst.merchants_with_pending_invoices.first.id
    last = @sales_analyst.merchants_with_pending_invoices.last.name

    assert_equal 7, pending
    assert_equal 12_334_141, first
    assert_equal 'handicraftcallery', last
  end

  def test_merchants_with_only_one_item_registered_in_month
    merchants = @sales_analyst.merchants_with_only_one_item_registered_in_month('June')
    assert_equal 12_334_141, merchants.first.id
    assert_equal 12_334_105, merchants.last.id
  end

  def test_to_check_if_merchant_invoices_are_successful
    merchant1 = @se.merchants.all[0]
    merchant2 = @se.merchants.all[1]
    merchant3 = @se.merchants.all[7]

    assert @sales_analyst.check_if_merchant_invoices_are_successful(merchant1)
    assert @sales_analyst.check_if_merchant_invoices_are_successful(merchant2)
    refute @sales_analyst.check_if_merchant_invoices_are_successful(merchant3)
  end

  def test_to_find_which_merchants_only_has_one_item
    @sales_analyst.merchants_with_only_one_item.length do |merchant|
      assert_instance_of Merchant, merchant
    end

    assert_equal 3, @sales_analyst.merchants_with_only_one_item.length
    assert_equal 'jejum', @sales_analyst.merchants_with_only_one_item[0].name
    assert_equal 12_334_183, @sales_analyst.merchants_with_only_one_item.last.id
  end

  def test_to_find_top_revenue_earners
    @sales_analyst.top_revenue_earners do |merchant|
      assert_instance_of Merchant, merchant
    end
    assert_equal 8, @sales_analyst.top_revenue_earners.length
    assert_equal 12_334_141, @sales_analyst.top_revenue_earners.first.id
    assert_equal 22_334_105, @sales_analyst.top_revenue_earners.last.id
  end

  def test_to_find_merchants_ranked_by_revenue
    @sales_analyst.merchants_ranked_by_revenue do |merchant|
      assert_instance_of Merchant, merchant
    end
    assert_equal 8, @sales_analyst.merchants_ranked_by_revenue.length
    assert_equal 12_334_141, @sales_analyst.merchants_ranked_by_revenue.first.id
    assert_equal 22_334_105, @sales_analyst.merchants_ranked_by_revenue.last.id
  end

  def test_revenue_by_merchant
    assert_equal 52_395.72, @sales_analyst.revenue_by_merchant(12_334_141)
  end

  def test_most_sold_item_for_merchant
    items = @sales_analyst.most_sold_item_for_merchant(12_334_141)

    assert_equal 263_415_463, items.first.id
  end

  def test_invoice_item_keys
    invoices = @se.find_invoices_by_merchant_id(12_334_141)
    result = @sales_analyst.invoice_items_keys(invoices, {})

    result.each { |invoice| assert_instance_of Invoice, invoice }
    assert_equal 9, result.length
  end

  def test_populate_items
    invoices = @se.find_invoices_by_merchant_id(12_334_141)
    invoices.each do |invoice|
      next unless invoice.is_paid_in_full?
      invoice_items = @se.find_invoice_items_by_invoice_id(invoice.id)
      result = @sales_analyst.populate_items(invoice_items, {})

      result.each { |invoiceitem| assert_instance_of InvoiceItem, invoiceitem }
      assert_equal 5, result.length
    end
  end

  def test_find_best_items
    invoices = @se.find_invoices_by_merchant_id(12_334_141)
    @sales_analyst.invoice_items_keys(invoices, items = {})
    best_value = (items.max_by { |_, value| value })[1]
    items = items.find_all { |_, value| value == best_value }
    result = @sales_analyst.find_best_item(items)

    result.each { |item| assert_instance_of Item, item }
    assert_equal 1, result.length
  end

  def test_best_item_for_merchant
    item = @sales_analyst.best_item_for_merchant(12_334_141)
    assert_equal 263_415_463, item.id
  end

  def test_parse_invoice_items
    invoices = @se.find_invoices_by_merchant_id(12_334_141)
    result = @sales_analyst.parse_invoice_items(invoices, {})

    result.each { |invoice| assert_instance_of Invoice, invoice }
    assert_equal 9, result.length
  end

  def test_item_pricing
    items = {}
    invoices = @se.find_invoices_by_merchant_id(12_334_141)
    invoices.each do |invoice|
      next unless invoice.is_paid_in_full?
      invoice_items = @se.find_invoice_items_by_invoice_id(invoice.id)
      result = @sales_analyst.item_pricing(invoice_items, items)

      result.each { |invoiceitem| assert_instance_of InvoiceItem, invoiceitem }
      assert_equal 5, result.length
    end
  end

  def test_it_can_get_total_price_for_item
    items = {}
    invoices = @se.find_invoices_by_merchant_id(12_334_141)
    invoices.each do |invoice|
      next unless invoice.is_paid_in_full?
      invoice_items = @se.find_invoice_items_by_invoice_id(invoice.id)
      invoice_items.each do |iitem|
        result = @sales_analyst.get_total_price_for_item(items, iitem)

        assert result.class == BigDecimal
      end
    end
  end
end
