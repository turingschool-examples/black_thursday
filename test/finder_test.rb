require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/merchant"
require "./lib/item"


class FinderTest < Minitest::Test

  attr_reader :sales_analyst

  def setup
    csv_hash = {
      :items     => "./test/test_fixtures/items_medium.csv",
      :merchants => "./test/test_fixtures/merchants_medium.csv",
      :invoices => ".//test/test_fixtures/invoices_medium.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./test/test_fixtures/transactions_medium.csv",
      :customers => "./test/test_fixtures/customers_medium.csv"
    }
    sales_engine = SalesEngine.from_csv(csv_hash)
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_it_finds_merchants_for_created_at_month
    assert_instance_of Array, sales_analyst.merchants_for_month("January")
    assert_instance_of Merchant, sales_analyst.merchants_for_month("January")[0]
  end

  def test_it_finds_invoices_for_merchant_id
    assert_instance_of Array, sales_analyst.merchant_invoices(12334146)
    assert_instance_of Invoice, sales_analyst.merchant_invoices(12334146)[0]
  end

  def test_it_find_merchant_items_for_merchant_id
    assert_instance_of Array, sales_analyst.merchant_items(12334257)
    assert_instance_of Item, sales_analyst.merchant_items(12334257)[0]
  end

  def test_it_finds_all_invoices
    assert_instance_of Array, sales_analyst.invoices
    assert_instance_of Invoice, sales_analyst.invoices[0]
  end

  def test_it_navigates_to_invoice_repository
    assert_instance_of InvoiceRepository, sales_analyst.invoice_repo
  end

  def test_it_navigates_to_item_repository
    assert_instance_of ItemRepository, sales_analyst.item_repo
  end

  def test_it_navigates_to_merchant_repository
    assert_instance_of MerchantRepository, sales_analyst.merchant_repo
  end

end
