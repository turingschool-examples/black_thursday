require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_has_an_items_repository
    assert_instance_of ItemRepository, Fixture.sales_engine.items
  end

  def test_it_has_a_merchant_repository
    assert_instance_of MerchantRepository, Fixture.sales_engine.merchants
  end

  def test_it_has_an_invoice_repository
    assert_instance_of InvoiceRepository, Fixture.sales_engine.invoices
  end

  # def test_it_has_an_invoice_item_repository
  #   assert_instance_of InvoiceItemRepository, Fixture.sales_engine.invoice_items
  # end
  #
  # def test_it_has_an_customer_repository
  #   assert_instance_of CustomerRepository, Fixture.sales_engine.customers
  # end
  #
  # def test_it_has_an_transaction_repository
  #   assert_instance_of TransactionRepository, Fixture.sales_engine.transactions
  # end


  def test_initialize_takes_a_hash_of_repo_data_arrays
    assert_instance_of SalesEngine, SalesEngine.new(Fixture.data)
  end

  def test_its_repositories_start_empty_if_given_no_data
    skip
    empty_data = {
      items: [],
      invoices: [],
      # invoice_items: [],
      # customers: [],
      # transactions: [],
      merchants: []
    }
    empty = SalesEngine.new(empty_data)

    assert empty_data.all? { |type| empty.repo(type).all.empty? }
  end

  def test_its_repositories_start_full_if_given_data
    skip
    full_data = Fixture.data
    full = SalesEngine.new(full_data)

    assert full_data.none? { |type| full.repo(type).all.empty? }
  end

  def test_parse_csv_returns_a_hash_of_arrays_of_hashes_of_strings
    data = SalesEngine.parse_csv(Fixture.filenames)
    assert_instance_of Hash, data
    assert_instance_of Array, data[:items]
    assert_instance_of Hash, data[:items].first
    assert_instance_of String, data[:items].first[:id]
  end

  def test_parse_csv_returns_data_suitable_for_initialize
    data = SalesEngine.parse_csv(Fixture.filenames)
    assert_instance_of SalesEngine, SalesEngine.new(data)
  end

  def test_from_csv_returns_sales_engine_instantiated_with_data_from_files
    assert_instance_of SalesEngine, SalesEngine.from_csv(Fixture.filenames)
  end

end
