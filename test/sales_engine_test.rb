require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
                                 items:      "./data/items.csv",
                             merchants:  "./data/merchants.csv",
                              invoices:   "./data/invoices.csv",
                          transactions:   "./data/transactions.csv",
                         invoice_items:   "./data/invoice_items.csv",
                              })
  end

  def test_it_exist_with_attributes
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_sales_engine_can_build_repos

    assert_equal MerchantRepository, @sales_engine.merchants.class
    assert_equal ItemRepository, @sales_engine.items.class
    assert_equal InvoiceRepository, @sales_engine.invoices.class
    assert_equal TransactionRepository, @sales_engine.transactions.class
  end
  #
  def test_it_creates_new_analyst
    assert_instance_of SalesAnalyst, @sales_engine.analyst
  end

  def test_it_finds_merchant_items
    assert_equal 3, @sales_engine.merchant_items(12334105).length
    assert_equal "Vogue Patterns/Patron 9712", @sales_engine.merchant_items(12334105)[2].name
  end

  def test_it_finds_merchant_invoices
    assert_equal 10, @sales_engine.merchant_invoices(12334105).length
    assert_equal 10, @sales_engine.merchant_invoices(12334220).length
    assert_equal 12, @sales_engine.merchant_invoices(12334275).length
    assert_equal 7, @sales_engine.merchant_invoices(12337411).length
    assert_equal Array, @sales_engine.merchant_invoices(12334275).class
  end

  def test_it_can_build_merchant_invoice_count_array
    assert_equal 475, @sales_engine.all_merchant_invoices.length
    assert_equal 4985, @sales_engine.all_merchant_invoices.sum
    assert_equal Array, @sales_engine.all_merchant_invoices.class
  end

  def test_it_can_count_the_number_of_invoices_by_status
    assert_equal 673, @sales_engine.invoice_status_count(:returned)
    assert_equal 1473, @sales_engine.invoice_status_count(:pending)
    assert_equal 2839, @sales_engine.invoice_status_count(:shipped)
  end

  def test_invoices_per_day_count
    answer = {:saturday=>729, :friday=>701, :wednesday=>741, :monday=>696, :sunday=>708, :tuesday=>692, :thursday=>718}
    assert_equal answer, @sales_engine.invoices_per_day_count
  end

  def test_total_revenue_by_date
    assert_equal "2009-02-07", @sales_engine.invoices_by_date("2009-02-07").first.created_at.strftime('%Y-%m-%d')
    assert_equal 1, @sales_engine.invoices_by_date("2009-02-07").count
    assert_equal 21067.77, @sales_engine.total_revenue_by_date("2009-02-07")
    assert_equal BigDecimal, @sales_engine.total_revenue_by_date("2009-02-07").class
  end

  def test_merchants_with_pending_invoices
    assert_equal 2175, @sales_engine.pending_invoices.count
    assert_equal 467, @sales_engine.merchants_with_pending_invoices.count
    assert_equal Merchant, @sales_engine.merchants_with_pending_invoices.first.class
  end
end
