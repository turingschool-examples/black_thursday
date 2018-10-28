require_relative 'test_helper'
require_relative './test_setup'

require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  include TestSetup

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

    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 3, status: :shipped)
    @se.invoice_items.create(id: 1, item_id: 1, invoice_id: 2, unit_price: BigDecimal(500), quantity: 2)

    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)

    actual = @sa.merchants_ranked_by_revenue
    assert_equal 'JC', actual[0].name
    assert_equal "Bob's Burgers", actual[1].name

  end

  def test_top_revenue_earners_with_integer_as_argument
    setup_fixtures
    actual = @sa.top_revenue_earners(4)
    first = actual[0]
    last = actual[-1]

    assert_equal 4, actual.size
    assert_equal 12334185, first.id
    assert_equal 12334105, last.id
  end

  def test_top_revenue_earners_returns_20_as_default
    setup_empty_sales_engine
    for i in 1..30
      # require 'pry'; binding.pry
      @se.merchants.create(id: i, name: "Most Unique Merchant#{i}")
    end
    actual = @sa.top_revenue_earners
    assert_equal 20, actual.size
    assert_instance_of Merchant, actual[0]
    assert_instance_of Merchant, actual[-1]
  end

  def test_revenue_by_date
    setup_empty_sales_engine
    time = Time.parse('2014-03-04')
    @se.merchants.create(id: 1, name: "King Soopers")
    @se.merchants.create(id: 2, name: "Amazon")
    @se.merchants.create(id: 3, name: "Bob's Burgers")
    @se.merchants.create(id: 4, name: "JC")
    @se.items.create(id: 1, name: 'burger', merchant_id: '3', unit_price: BigDecimal(500), merchant_id: 3)
    @se.items.create(id: 2, name: "3D printed Jaguar", unit_price: BigDecimal(100_000_00), merchant_id: 4)
    @se.items.create(id: 3, name: "3D printed packing peanut", unit_price: BigDecimal(1), merchant_id: 4)

    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped, created_at: time)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 2)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 1, unit_price: BigDecimal(1), quantity: 5)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)


    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 3, status: :shipped, created_at: time)
    @se.invoice_items.create(id: 1, item_id: 1, invoice_id: 2, unit_price: BigDecimal(500), quantity: 200)
    @se.transactions.create(id:1, invoice_id: 2, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)



    assert_equal 201_000_05, @sa.total_revenue_by_date(time)
  end

  def test_merchants_with_only_one_item_registered_in_month
    setup_empty_sales_engine

    @se.merchants.create(id: 3, name: "Bob's Burgers")
    @se.merchants.create(id: 4, name: "Bret's Burgers")

    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 3, status: :shipped, created_at: Time.new(2013, 10))
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 3, status: :pending, created_at: Time.new(2013, 10))

    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped, created_at: Time.new(2013, 10))
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :pending, created_at: Time.new(2013, 11))

    result = @sa.merchants_with_only_one_item_registered_in_month("October")

    assert_equal 1, result.length
    assert_equal Merchant, result.first.class
    assert_equal 4, result.first.id
end


end
