require_relative '../lib/sales_engine'
require_relative './test_helper'

class SalesEngineTest < Minitest::Test
  def test_sales_engine_exists
    se = SalesEngine.from_csv({items: './data/items.csv',
                              merchants: './data/merchants.csv',
                              invoices: './data/invoices.csv',
                              invoice_items: './data/invoice_items.csv',
                              transactions: './data/transactions.csv',
                              customers: './data/customers.csv'
                              })
    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_receives_data_from_csv
    se = SalesEngine.from_csv({items: './data/items.csv',
                              merchants: './data/merchants.csv',
                              invoices: './data/invoices.csv',
                              invoice_items: './data/invoice_items.csv',
                              transactions: './data/transactions.csv',
                              customers: './data/customers.csv'
                              })

    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
    assert_instance_of InvoiceRepository, se.invoices
    assert_instance_of InvoiceItemRepository, se.invoice_items
    assert_instance_of TransactionRepository, se.transactions
    assert_instance_of CustomerRepository, se.customers
  end

  def test_sales_engine_has_sales_analyst
    se = SalesEngine.from_csv({items: './data/items.csv',
                              merchants: './data/merchants.csv',
                              invoices: './data/invoices.csv',
                              invoice_items: './data/invoice_items.csv',
                              transactions: './data/transactions.csv',
                              customers: './data/customers.csv'
                              })

    assert_instance_of SalesAnalyst, se.analyst
  end
end
