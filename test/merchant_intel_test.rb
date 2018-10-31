require_relative 'test_helper'

require './lib/sales_engine'

class MerchantIntelligenceTest < Minitest::Test
  include TestSetup
  def setup_merchant_intel_test_data
    setup_empty_sales_engine
    @se.merchants.create(id: 1, name: "Bob's Burgers")

    @se.items.create(id: 1, name: "burger", merchant_id: 1)
    @se.items.create(id: 2, name: "cheeseburger", merchant_id: 1)
    @se.items.create(id: 3, name: "veggieburger", merchant_id: 1)

    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 1, status: :shipped)
    @se.invoice_items.create(id: 2, item_id: 1, invoice_id: 1, unit_price: BigDecimal(5_00), quantity: 2)
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 1, status: :shipped)
    @se.invoice_items.create(id: 2, item_id: 2, invoice_id: 2, unit_price: BigDecimal(5_00), quantity: 3)
    @se.invoices.create(id: 3, customer_id: 1, merchant_id: 1, status: :shipped)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 3, unit_price: BigDecimal(5_00), quantity: 1)

    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success)
    @se.transactions.create(id:2, invoice_id: 2, credit_card_number: 2, result: :success)
    @se.transactions.create(id:3, invoice_id: 3, credit_card_number: 2, result: :success)

    @se.merchants.create(id: 2, name: "Bret's Burgers")

    @se.items.create(id: 1, name: "burger", merchant_id: 2)
    @se.items.create(id: 2, name: "cheeseburger", merchant_id: 2)
    @se.items.create(id: 3, name: "veggieburger", merchant_id: 2)

    @se.invoices.create(id: 4, customer_id: 1, merchant_id: 2, status: :shipped)
    @se.invoice_items.create(id: 4, item_id: 1, invoice_id: 4, unit_price: BigDecimal(5_00), quantity: 2)
    @se.transactions.create(id:4, invoice_id: 4, credit_card_number: 2, result: :failed)

  end

  def test_best_item_for_merchant
    setup_merchant_intel_test_data
    assert_equal 2, @sa.best_item_for_merchant(1).id
  end

  def test_most_sold_item_for_merchant
    setup_merchant_intel_test_data
    assert @sa.most_sold_item_for_merchant(1).map(&:id).include?(2)
  end

  def test_merchants_with_pending_invocies
    setup_merchant_intel_test_data
    assert @sa.merchants_with_pending_invoices.map(&:id).include?(2)
    assert !@sa.merchants_with_pending_invoices.map(&:id).include?(1)
  end

  def test_merchants_with_only_one_item_registered_in_month
    setup_empty_sales_engine

    @se.merchants.create(id: 2, name: "Bart's Burgers", created_at: Time.new(2013, 11))
    @se.merchants.create(id: 3, name: "Bob's Burgers", created_at: Time.new(2013, 10))
    @se.merchants.create(id: 4, name: "Bret's Burgers", created_at: Time.new(2013, 10))

    @se.items.create(id: 1, name:"burger", description: "Mmmm", merchant_id: 2)
    @se.items.create(id: 2, name:"burger", description: "Mmmm", merchant_id: 4)
    @se.items.create(id: 3, name:"burger", description: "Mmmm", merchant_id: 3)
    @se.items.create(id: 4, name:"burger", description: "Mmmm", merchant_id: 3)

    result = @sa.merchants_with_only_one_item_registered_in_month("October")

    assert_equal 1, result.length
    assert_equal Merchant, result.first.class
    assert_equal 4, result.first.id
  end

  def test_merchants_with_high_item_count
    setup_fixtures
    assert_equal 1, @sa.merchants_with_high_item_count.size
  end

  def test_top_merchants_by_invoice_count
    setup_fixtures
    assert_equal 0, @sa.top_merchants_by_invoice_count.size
  end

  def test_bottom_merchants_by_invoice_count
    setup_fixtures
    assert_equal 0, @sa.bottom_merchants_by_invoice_count.size
  end

  def test_merchants_ranked_by_revenue_two_sellers
    setup_empty_sales_engine
    @se.merchants.create(id: 3, name: "Bob's Burgers")
    @se.merchants.create(id: 4, name: "JC")

    @se.items.create(id: 1, name: 'burger', unit_price: BigDecimal(500), merchant_id: '3')
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

  def test_merchants_with_only_one_item
    setup_empty_sales_engine

    @se.merchants.create(id: 3, name: "Bob's Burgers")
    @se.merchants.create(id: 4, name: "JC")

    @se.items.create(id: 1, name: 'burger', unit_price: BigDecimal(500), merchant_id: 3)
    @se.items.create(id: 2, name: "3D printed Jaguar", unit_price: BigDecimal(100_000_00), merchant_id: 4)
    @se.items.create(id: 3, name: "3D printed packing peanut", unit_price: BigDecimal(1), merchant_id: 4)

    result = @sa.merchants_with_only_one_item
    assert_equal 1, result.length
    assert_equal 3, result[0].id
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
    30.times do |i|
      @se.merchants.create(id: i, name: "Most Unique Merchant#{i}")
    end
    actual = @sa.top_revenue_earners
    assert_equal 20, actual.size
    assert_instance_of Merchant, actual[0]
    assert_instance_of Merchant, actual[-1]
  end

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
end
