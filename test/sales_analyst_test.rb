require_relative 'test_helper'

require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup_big_data_set
    se = SalesEngine.from_csv(
      {
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv',
        customers: './data/customers.csv'
      }
    )
    @sa = se.analyst
  end

  def setup_fixtures
    se = SalesEngine.from_csv(
      {
        items: './test/data/test_items.csv',
        merchants: './test/data/test_merchants.csv',
        invoices: './test/data/test_invoices.csv',
        invoice_items: './test/data/test_invoice_items.csv',
        transactions: './test/data/test_transactions.csv',
        customers: './test/data/test_customers.csv'
      }
    )
    @sa = se.analyst
  end

  def setup_empty_sales_engine
    item_repository = ItemRepository.new
    merchant_repository = MerchantRepository.new
    invoice_repository = InvoiceRepository.new
    invoice_items_repository = InvoiceItemRepository.new
    customers_repository = CustomerRepository.new
    transactions_repository = TransactionRepository.new
    @se = SalesEngine.new(item_repository, merchant_repository, invoice_repository, invoice_items_repository, customers_repository, transactions_repository)
    @sa = @se.analyst
  end

  def test_average_items_per_merchant
    setup_fixtures
    assert_equal 4.86, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    setup_fixtures
    assert_equal 6.91, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    setup_fixtures
    assert_equal 1, @sa.merchants_with_high_item_count.size
  end

  def test_average_item_price_for_merchant
    setup_fixtures
    assert_equal 0.8, @sa.average_item_price_for_merchant(12334235)
  end

  def test_average_average_price_per_merchant
    setup_fixtures
    assert_equal 0.88, @sa.average_average_price_per_merchant
  end

  def test_golden_items
    setup_fixtures
    assert_equal 0, @sa.golden_items.length
  end

  def test_it_finds_percentage_of_invoices_status_returned
    setup_fixtures
    assert_equal 19.18, @sa.invoice_status(:returned)
  end

  def test_it_finds_percentage_of_invoices_status_pending
    setup_fixtures

    assert_equal 39.73, @sa.invoice_status(:pending)
  end

  def test_it_finds_percentage_of_invoices_status_shipped
    setup_fixtures
    assert_equal 41.1, @sa.invoice_status(:shipped)
  end

  def test_average_invoices_per_merchant
    setup_fixtures
    assert_equal 10.43, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    setup_fixtures
    assert_equal 4.79, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    setup_fixtures
    assert_equal 0, @sa.top_merchants_by_invoice_count.size
  end

  def test_bottom_merchants_by_invoice_count
    setup_fixtures

    assert_equal 0, @sa.bottom_merchants_by_invoice_count.size
  end

  def test_top_days_by_invoice_count
    setup_fixtures
    assert_equal [], @sa.top_days_by_invoice_count
  end




  #iteration 4 tests

  def test_revenue_by_merchant
    setup_empty_sales_engine
    @se.merchants.create(id: 4, name: "JC")

    @se.items.create(id: 2, name: "3D printed Jaguar", unit_price: BigDecimal(100_000_00), merchant_id: 4)

    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)

    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 1)

    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)


    assert_equal 100_000_00, @sa.revenue_by_merchant(4)
  end

  def test_revenue_by_merchant_double_quantity
    setup_empty_sales_engine
    @se.merchants.create(id: 1, name: "King Soopers")
    @se.merchants.create(id: 2, name: "Amazon")
    @se.merchants.create(id: 3, name: "Bob's Burgers")
    @se.merchants.create(id: 4, name: "JC")

    @se.items.create(id: 1, name: 'burger', merchant_id: '3', unit_price: BigDecimal(500), merchant_id: 3)
    @se.items.create(id: 2, name: "3D printed Jaguar", unit_price: BigDecimal(100_000_00), merchant_id: 4)

    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)

    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 2)

    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)


    assert_equal 200_000_00, @sa.revenue_by_merchant(4)
  end

  def test_revenue_by_merchant_double_quantity_and_another_item
    setup_empty_sales_engine
    @se.merchants.create(id: 1, name: "King Soopers")
    @se.merchants.create(id: 2, name: "Amazon")
    @se.merchants.create(id: 3, name: "Bob's Burgers")
    @se.merchants.create(id: 4, name: "JC")

    @se.items.create(id: 1, name: 'burger', merchant_id: '3', unit_price: BigDecimal(500), merchant_id: 3)
    @se.items.create(id: 2, name: "3D printed Jaguar", unit_price: BigDecimal(100_000_00), merchant_id: 4)
    @se.items.create(id: 3, name: "3D printed packing peanut", unit_price: BigDecimal(1), merchant_id: 4)

    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)

    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 2)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 1, unit_price: BigDecimal(1), quantity: 5)

    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)


    assert_equal 200_000_05, @sa.revenue_by_merchant(4)
  end

  def test_merchants_ranked_by_revenue_two_sellers
    setup_empty_sales_engine
    @se.merchants.create(id: 3, name: "Bob's Burgers")
    @se.merchants.create(id: 4, name: "JC")

    @se.items.create(id: 1, name: 'burger', merchant_id: '3', unit_price: BigDecimal(500), merchant_id: 3)
    @se.items.create(id: 2, name: "3D printed Jaguar", unit_price: BigDecimal(100_000_00), merchant_id: 4)
    @se.items.create(id: 3, name: "3D printed packing peanut", unit_price: BigDecimal(1), merchant_id: 4)

    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)

    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 2)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 1, unit_price: BigDecimal(1), quantity: 5)

    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)

    actual = @sa.merchants_ranked_by_revenue
    assert_equal 'JC', actual[0].name
    assert_equal "Bob's Burgers", actual[1].name

  end

  # def test_merchants_ranked_by_revenue_with_large_dataset
  #   setup_big_data_set
  #   binding.pry
  #   assert_equal 7, @sa.merchants_ranked_by_revenue.size
  # end


end
