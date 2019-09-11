require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    paths = {
    :items                => './data/items.csv',
    :merchants            => './data/merchants.csv',
    :invoices             => './data/invoices.csv',
    :invoice_items        => './data/invoice_items.csv',
    :transactions         => './data/transactions.csv',
    :customers            => './data/customers.csv'
  }
    @se = SalesEngine.from_csv(paths)
  end

  def test_sales_engine_exists
    assert_instance_of SalesEngine, @se
  end

  def test_sales_engine_can_return_instances_of_all_repositories
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of InvoiceRepository, @se.invoices
    assert_instance_of InvoiceItemRepository, @se.invoice_items
    assert_instance_of TransactionRepository, @se.transactions
    assert_instance_of CustomerRepository, @se.customers
  end

  def test_sales_engine_converts_a_given_csv_to_an_array_of_hashes
    path = './data/items.csv'

    item_hashes = @se.csv_to_hash(path)

    assert_instance_of Array, item_hashes
    assert_instance_of Hash, item_hashes[0]
    assert_equal "263395237", item_hashes[0][:id]
  end

  def test_all_item_hashes_contain_all_item_attributes_contents
    path = './data/items.csv'

    item_hashes = @se.csv_to_hash(path)
    keys = item_hashes.keys

    assert_equal true, item_hashes.all? do |hash|
      hash[:id] != nil
    end
    assert_equal true, keys.one?{|key| key == :name}
    assert_equal true, keys.one?{|key| key == :description}
    assert_equal true, keys.one?{|key| key == :unit_price}
    assert_equal true, keys.one?{|key| key == :created_at}
    assert_equal true, keys.one?{|key| key == :updated_at}
  end
end
