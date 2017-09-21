require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/merchant"
require "./lib/item"


class FinderTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    csv_hash = {
      :items     => "./test/test_fixtures/items_medium.csv",
      :merchants => "./test/test_fixtures/merchants_medium.csv",
      :invoices => ".//test/test_fixtures/invoices_medium.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./test/test_fixtures/transactions_medium.csv",
      :customers => "./test/test_fixtures/customers_medium.csv"
    }
    @sales_engine = SalesEngine.from_csv(csv_hash)
  end

  def test_it_finds_merchants_for_created_at_month

  end

  def test_it_finds_invoices_for_merchant_id

  end

  def test_it_find_merchant_items_for_merchant_id

  end

  def test_it_finds_all_invoices

  end

  def test_it_navigates_to_invoice_repository

  end

  def test_it_navigates_to_item_repository

  end

  def test_it_navigates_to_merchant_repository

  end

end
