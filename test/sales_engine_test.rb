require_relative 'test_helper'

require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'

require_relative '../lib/sales_engine'


class SalesEngineTest < Minitest::Test

  def setup
    hash = {
              # :items         => "./data/items.csv",
              # :merchants     => "./data/merchants.csv",
              # :invoices      => "./data/invoices.csv",
              :invoice_items => "./data/invoice_items.csv",
              # :transactions  => "./data/transactions.csv",
              :customers     => "./data/customers.csv"
            }
    @se_new = SalesEngine.new({})
    @se_csv = SalesEngine.from_csv(hash)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se_new
  end

  def test_it_can_be_created_via_from_csv_method
    assert_instance_of SalesEngine, @se_csv
  end

  def test_it_gets_attrubutes
    # --- From empty hash ---
    assert_nil @se_new.merchants
    assert_nil @se_new.items
    assert_nil @se_new.invoices
    assert_nil @se_new.invoice_items
    assert_nil @se_new.transactions
    assert_nil @se_new.customers
    # --- From CSV ---
    # assert_instance_of MerchantRepository,    @se_csv.merchants
    # assert_instance_of ItemRepository,        @se_csv.items
    # assert_instance_of InvoiceRepository,     @se_csv.invoices
    assert_instance_of InvoiceItemRepository, @se_csv.invoice_items
    # assert_instance_of TransactionRepository, @se_csv.transactions
    assert_instance_of CustomerRepository,    @se_csv.customers
  end


  # --- Sales Analyst ---

  def test_it_makes_a_sales_analyst
    assert_instance_of SalesAnalyst, @se_new.analyst
    assert_instance_of SalesAnalyst, @se_csv.analyst
  end




end
