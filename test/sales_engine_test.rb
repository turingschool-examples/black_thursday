require_relative "test_helper"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_instantiates_merchant_repository
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_sales_engine_instantiates_item_repository
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    assert_instance_of ItemRepository, se.items
  end

  def test_sales_engine_instantiates_invoice_repository
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_merchant_repository_has_merchants
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    all_merchants = se.merchants.all

    all_merchants.map do |merchant|
      assert_instance_of Merchant, merchant
    end
  end

  def test_item_repository_has_items
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    all_items = se.items.all

    all_items.map do |item|
      assert_instance_of Item, item
    end
  end

  def test_item_is_linked_to_merchant
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    item = se.items.find_by_id(263395237)

    assert_equal "SeriousCompany", item.merchant.name
  end

  def test_merchant_is_linked_to_item
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    invoice_1 = se.merchants.find_by_id(12334141)
    invoice_2 = se.merchants.find_by_id(12334185)

    assert_equal "510+ RealPush Icon Set", invoice_1.items.first.name
    invoice_1.items.each do |item|
      assert_instance_of Item, item
    end
    assert_equal 3, invoice_1.items.count
    invoice_2.items.each do |item|
      assert_instance_of Item, item
    end
    assert_equal 3, invoice_2.items.count
  end

  def test_get_all_merchant_items_returns_hash_of_merchants_and_items
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    merchants_and_items = se.get_all_merchant_items
    merchants = merchants_and_items.keys
    items = merchants_and_items.values.flatten

    sorted_items = items.sort_by {|item| item.id}
    sorted_items = sorted_items.map {|item| item.id}
    sorted_expected_items = se.items.all.sort_by {|item| item.id}
    sorted_expected_items = sorted_expected_items.map {|item| item.id}

    assert_equal se.merchants.all, merchants
    assert_equal sorted_expected_items, sorted_items
  end

  def test_get_all_merchant_prices_returns_hash_of_merchant_and_prices
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    merchants_and_prices = se.get_all_merchant_prices
    merchants = merchants_and_prices.keys
    prices = merchants_and_prices.values.flatten

    assert_instance_of Hash, merchants_and_prices
    assert_equal se.merchants.all, merchants
    prices.each do |price|
      assert_instance_of BigDecimal, price
    end
  end

  def test_get_one_merchant_prices_returns_array_of_merchant_prices
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    assert_equal [12.0, 13.5, 7.0],  se.get_one_merchant_prices(12334185)
  end

  def test_search_ir_by_price_returns_all_items_with_given_price
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    items =  se.search_ir_by_price(12.00)
    item_ids = items.map { |item| item.id }

    assert_equal [263395237, 263395617], item_ids
  end

  def test_find_by_merchant_id_invoices_specific_to_merchant
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    invoice_1 = se.merchants.find_by_id(12334141)
    invoice_2 = se.merchants.find_by_id(12334185)

    invoice_1.invoices.each do |invoice|
      assert_instance_of Invoice, invoice
    end
    invoice_2.invoices.each do |invoice|
      assert_instance_of Invoice, invoice
    end
    assert_equal 5, invoice_1.invoices.count
    assert_equal 9, invoice_2.invoices.count
    assert_equal 4, invoice_1.invoices.first.id
    assert_equal 1, invoice_2.invoices.first.id
  end

  def test_find_by_invoice_id_returns_merchant_id
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    invoice_1 = se.invoices.find_by_id(6)
    invoice_2 = se.invoices.find_by_id(18)

    assert_instance_of Invoice, invoice_1
    assert_instance_of Invoice, invoice_2

    assert_equal 12334185, invoice_1.merchant.id
    assert_equal 12334141, invoice_2.merchant.id
  end

  def test_get_item_ids_from_invoice_id_works
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    assert_equal [263396517, 263396255], se.get_item_ids_from_invoice_id(13)
  end

  def test_get_items_from_invoice_id_works
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    invoice = se.invoices.find_by_id(13)
    items = invoice.items

    assert_equal 2, items.count
    assert_equal 400.00, items[0].unit_price
    assert_equal 149.00, items[1].unit_price
  end

  def test_get_transactions_from_invoice_id_works
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    invoice = se.invoices.find_by_id(13)
    transactions = invoice.transactions

    assert_equal 2, transactions.count
    assert_equal 4297222478855497, transactions[0].credit_card_number
    assert_equal 4890371279632775, transactions[1].credit_card_number
  end

  def test_get_customer_from_customer_id_works
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    invoice = se.invoices.find_by_id(13)
    customer = invoice.customer

    assert_equal "Mariah", customer.first_name
    assert_equal "Toy", customer.last_name
  end

  def test_get_invoice_from_invoice_id_works
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    transaction = se.transactions.find_by_id(13)
    invoice = transaction.invoice

    assert_equal 12334141, invoice.merchant_id
  end

  def test_get_customer_ids_from_merchant_id_works
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    customer_ids = se.get_customer_ids_from_merchant_id(12334185)

    assert_equal 4, customer_ids.count
  end

  def test_get_customers_from_merchant_id_works
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    merchant = se.merchants.find_by_id(12334185)
    customers = merchant.customers

    assert_equal 4, customers.count
    assert_equal "Ondricka", customers[0].last_name
    assert_equal "Osinski", customers[1].last_name
    assert_equal "Toy", customers[2].last_name
    assert_equal "Nader", customers[3].last_name
  end

  def test_get_merchant_ids_from_customer_ids_works
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    merchant_ids = se.get_merchant_ids_from_customer_ids(2)

    assert_equal 3, merchant_ids.count
    assert_equal 12334141, merchant_ids[0]
    assert_equal 12334185, merchant_ids[2]
  end

  def test_get_customers_from_merchant_id_works
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    customer = se.customers.find_by_id(2)
    merchants = customer.merchants

    assert_equal 3, merchants.count
    assert_equal "SeriousCompany", merchants[0].name
    assert_equal "Disney", merchants[2].name
  end

  def test_is_invoice_paid_in_full_returns_true_if_all_transaction_results_are_successful
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    invoice_1 = se.invoices.find_by_id(19)
    invoice_2 = se.invoices.find_by_id(20)
    invoice_3 = se.invoices.find_by_id(5)

    refute invoice_3.is_paid_in_full?
    refute invoice_1.is_paid_in_full?
    assert invoice_2.is_paid_in_full?
  end

  def test_is_get_invoice_total_returns_total_cost_of_all_items_for_invoice
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixture.csv",
                                customers: "./test/fixtures/customer_fixture.csv" })

    invoice_1 = se.invoices.find_by_id(19)
    invoice_2 = se.invoices.find_by_id(20)

    assert_equal 4912.10, invoice_1.total
    assert_equal 10251.94, invoice_2.total
  end

end
