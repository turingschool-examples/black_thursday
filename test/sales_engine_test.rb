require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_reads_a_merchants_csv_file
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })

    assert_equal "12334105", se.read_merchants_data[0][0]
  end

  def test_it_reads_an_items_csv_file
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })

    assert_equal "263395237", se.read_items_data[0][0]
  end

  def test_it_creates_a_merchant_repository
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })

    assert_equal true, se.merchants.is_a?(MerchantRepository)
  end

  def test_it_creates_an_items_repository
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })

    assert_equal true, se.items.is_a?(ItemRepository)
  end

  def test_it_creates_an_invoices_repository
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv", invoices: "./test/samples/invoices_sample.csv" })

    assert_equal true, se.invoices.is_a?(InvoiceRepository)
  end

  def test_it_creates_a_transaction_repository
    se = SalesEngine.from_csv({ transactions: "./data/transactions_sample.csv"})

    assert_equal true, se.transactions.is_a?(TransactionRepository)
  end

  def test_it_creates_a_customer_repository
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv"})

    assert_equal true, se.customers.is_a?(CustomerRepository)
  end

  def test_it_splits_merchant_entries_correctly
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })

    assert_equal "LolaMarleys", se.read_merchants_data[3][1]
  end

  def test_it_splits_item_entries_correctly
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })

    assert_equal "Glitter scrabble frames", se.read_items_data[1][1]
  end

  def test_it_splits_invoice_entries_correctly
    se = SalesEngine.from_csv({ invoices: "./test/samples/invoices_sample.csv" })

    assert_equal "12335955", se.read_invoices_data[2][2]
  end

  def test_it_splits_transaction_entries_correctly
    se = SalesEngine.from_csv({ transactions: "./data/transactions_sample.csv" })

    assert_equal "4126", se.read_transactions_data[3][1]
  end

  def test_it_splits_customer_entries_correctly
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv" })

    assert_equal "Sylvester", se.read_customers_data[4][1]
  end

  def test_it_converts_headers_to_symbols
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })

    assert_equal "LolaMarleys", se.read_merchants_data[3][:name]
    assert_equal "Glitter scrabble frames", se.read_items_data[1][:name]
  end

end
