require './lib/sales_engine'
require_relative 'test_helper'
require_relative 'test_data'

class CustomerIntelligenceTest < Minitest::Test
  include TestData
  def setup
    make_repositories
    @se = SalesEngine.new(@itemr,@mr,@ir,@iir,@cr,@tr)
    @sa = se.analyst
  end

  def test_it_finds_top_buyers
    make_top_buyers_test_data

    expected = [@customer_3, @customer_2, @customer_1]
    result = @sa.top_buyers

    assert_equal expected, result
  end

  def test_it_finds_one_time_buyers
    make_one_time_buyers_test_data

    assert_equal [@customer_1], @sa.one_time_buyers
  end

  def test_it_finds_one_time_buyers_top_item
    make_one_time_buyers_top_item_test_data

    assert_equal @item_1, @sa.one_time_buyers_top_item
  end

  def test_it_finds_top_merchant_for_customer
    make_top_merchant_and_invoice_items_test_data

    assert_equal @m, @sa.top_merchant_for_customer(@customer_1.id)
  end

  def test_it_finds_invoice_with_most_items_from_customer
    make_top_merchant_and_invoice_items_test_data

    assert_equal @inv_1, @sa.find_invoice_with_most_items_from(@customer_1)
  end

  def test_all_invoices_for_customer_for_year
    @se.invoices.create(id: 1, customer_id: 6, merchant_id: 1, status: :shipped, created_at: Time.new(2011))
    @se.invoices.create(id: 2, customer_id: 6, merchant_id: 1, status: :shipped, created_at: Time.new(2009))
    @se.invoices.create(id: 3, customer_id: 6, merchant_id: 1, status: :shipped, created_at: Time.new(2011))
    @se.invoices.create(id: 4, customer_id: 6, merchant_id: 1, status: :shipped, created_at: Time.new(2011))

    @se.customers.create(:id => 6, :first_name => "Joan", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now)

    actual = @sa.all_invoices_for_customer_for_year(6, 2011)
    assert_equal 3, actual.size
    refute actual.any? { |invoice| invoice.id ==2  }

  end

  def test_items_bought_in_year
    @se.invoices.create(id: 1, customer_id: 6, merchant_id: 1, status: :shipped, created_at: Time.new(2011))
    @se.invoices.create(id: 2, customer_id: 6, merchant_id: 1, status: :shipped, created_at: Time.new(1900))
    @se.items.create(id: 1, name: "burger", merchant_id: 1)
    @se.items.create(id: 2, name: "burger", merchant_id: 1)
    @se.items.create(id: 3, name: "burger", merchant_id: 1)
    @se.items.create(id: 4, name: "burger", merchant_id: 1)
    @se.invoice_items.create(id: 1, item_id: 1, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 4)
    @se.invoice_items.create(id: 2, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 4)
    @se.invoice_items.create(id: 3, item_id: 3, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 4)
    @se.invoice_items.create(id: 4, item_id: 4, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 4)
    @se.customers.create(:id => 6, :first_name => "Joan", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    actual = @sa.items_bought_in_year(6, 2011)
    assert_equal 3, actual.size
    refute actual.any? { |item| item.id == 3 }
  end

  def test_highest_volume_items
    @se.invoices.create(id: 1, customer_id: 6, merchant_id: 1, status: :shipped, created_at: Time.new(2011))
    @se.items.create(id: 1, name: "burger", merchant_id: 1)
    @se.items.create(id: 2, name: "burger", merchant_id: 1)
    @se.items.create(id: 3, name: "burger", merchant_id: 1)
    @se.items.create(id: 4, name: "burger", merchant_id: 1)
    @se.invoice_items.create(id: 1, item_id: 1, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 8)
    @se.invoice_items.create(id: 2, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 8)
    @se.invoice_items.create(id: 3, item_id: 3, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 4, item_id: 4, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 4)
    @se.customers.create(:id => 6, :first_name => "Joan", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    actual = @sa.highest_volume_items(6)
    assert_equal 2, actual.size
    refute actual.any? { |item| item.id == 3 }
    refute actual.any? { |item| item.id == 4 }
  end

  def test_customers_with_unpaid_invoices

    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)

    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 1, status: :shipped, created_at: Time.new(2011))
    @se.invoices.create(id: 2, customer_id: 2, merchant_id: 1, status: :shipped, created_at: Time.new(2011))
    @se.invoices.create(id: 3, customer_id: 3, merchant_id: 1, status: :shipped, created_at: Time.new(2011))
    @se.invoices.create(id: 4, customer_id: 4, merchant_id: 1, status: :shipped, created_at: Time.new(2011))
    @se.invoices.create(id: 5, customer_id: 4, merchant_id: 1, status: :shipped, created_at: Time.new(2011))
    @se.customers.create(:id => 1, :first_name => "Joan", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now)
    @se.customers.create(:id => 2, :first_name => "John", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now)
    @se.customers.create(:id => 3, :first_name => "Michale", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now)
    @se.customers.create(:id => 4, :first_name => "ben", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now)
    @se.customers.create(:id => 5, :first_name => "c", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now)
    @se.customers.create(:id => 6, :first_name => "d", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now)
    @se.customers.create(:id => 7, :first_name => "e", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now)
    actual = @sa.customers_with_unpaid_invoices
    assert_equal 3, actual.size
    refute actual.any? { |customer| customer.id == 1 }
    refute actual.any? { |customer| customer.id == 5 }
    refute actual.any? { |customer| customer.id == 6 }
    assert actual.any? { |customer| customer.id == 2 }
    assert actual.any? { |customer| customer.id == 3 }
    assert actual.any? { |customer| customer.id == 4 }
  end
end
