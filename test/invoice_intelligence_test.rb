require_relative 'test_helper'
require_relative './test_setup'

require './lib/sales_engine'
require './test/test_data'

class InvoiceIntelligenceTest < Minitest::Test
  include TestData, TestSetup

  def setup
    setup_empty_sales_engine
  end

  def setup_invoices_with_different_statuses
    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :pending)
    @se.invoices.create(id: 3, customer_id: 1, merchant_id: 4, status: :pending)
    @se.invoices.create(id: 4, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 5, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 6, customer_id: 1, merchant_id: 4, status: :returned)
    @se.invoices.create(id: 7, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 8, customer_id: 1, merchant_id: 4, status: :pending)
  end

  def setup_invoices_with_different_days_created
    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped, created_at: Time.new(2014, 10, 11))
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :pending, created_at: Time.new(2014, 10, 12))
    @se.invoices.create(id: 3, customer_id: 1, merchant_id: 4, status: :pending, created_at: Time.new(2014, 10, 13))
  end

  def test_it_finds_percentage_of_invoices_status_returned
    setup_invoices_with_different_statuses
    assert_equal 12.5, @sa.invoice_status(:returned)
  end

  def test_it_finds_percentage_of_invoices_status_pending
    setup_invoices_with_different_statuses
    assert_equal 37.5, @sa.invoice_status(:pending)
  end

  def test_it_finds_percentage_of_invoices_status_shipped
    setup_invoices_with_different_statuses
    assert_equal 50.0, @sa.invoice_status(:shipped)
  end

  def test_invoice_has_no_transactions
    invoice = @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    assert @sa.invoice_has_no_transactions?(invoice[0].id)
  end

  def test_invoice_paid_in_full_can_return_true
    invoice = @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    assert @sa.invoice_paid_in_full?(invoice[0].id)
  end

  def test_each_invoice_day
    setup_invoices_with_different_days_created
    assert_equal %w(Saturday Sunday Monday), @sa.each_invoice_day
  end

  def test_days_with_iv_count
    setup_invoices_with_different_days_created
    expected = {"Sunday"=>1, "Monday"=>1, "Tuesday"=>0, "Wednesday"=>0, "Thursday"=>0, "Friday"=>0, "Saturday"=>1}
    assert_equal expected, @sa.days_with_iv_count
  end

  def test_days_by_top_invoice_count
    setup_invoices_with_different_days_created
    assert_equal %w(Sunday Monday Saturday), @sa.top_days_by_invoice_count
  end

  def test_all_transactions_successful_for_invoice_id_returns_true
    invoice = @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    assert @sa.all_transactions_successful_for?(invoice[0].id)
  end

  def test_all_transactions_successful_for_invoice_id_returns_false_when_one_is_unsuccessful
    invoice = @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :failure, credit_card_expiration_date: Time.now)
    refute @sa.all_transactions_successful_for?(invoice[0].id)
  end

  def test_get_item_count_for_invoice_id
    invoice = @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 2)
    @se.invoice_items.create(id: 3, item_id: 4, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 3)
    @se.invoice_items.create(id: 4, item_id: 5, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 4)
    require 'pry'; binding.pry
    assert_equal 10, @sa.get_item_count_for(invoice[0])
  end

  def test_best_invoice_by_quantity
    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.transactions.create(id:1, invoice_id: 2, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 2)
    @se.invoice_items.create(id: 3, item_id: 4, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 3)
    @se.invoice_items.create(id: 4, item_id: 5, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 4)
    actual = @sa.best_invoice_by_quantity
    assert_instance_of Invoice, actual
    assert_equal 1, actual.id
  end

  def test_best_invoice_by_revenue
    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.transactions.create(id:1, invoice_id: 2, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 2)
    @se.invoice_items.create(id: 3, item_id: 4, invoice_id: 1, unit_price: BigDecimal(1), quantity: 3)
    @se.invoice_items.create(id: 4, item_id: 5, invoice_id: 1, unit_price: BigDecimal(20000), quantity: 4)
    actual = @sa.best_invoice_by_revenue
    assert_instance_of Invoice, actual
    assert_equal 2, actual.id
  end

  def test_quantity_of_invoice
    invoice = @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 2)
    @se.invoice_items.create(id: 4, item_id: 5, invoice_id: 2, unit_price: BigDecimal(20000), quantity: 4)
    assert_equal 7, @sa.quantity_of_invoice(invoice[0])
  end

  def test_revenue_from_invoices_returns_0_when_no_transactions
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 2, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 1)
    assert_equal 0, @sa.revenue_from_invoices(@se.invoices.all)
  end

  def test_revenue_from_invoices_returns_0_when_no_successful_transactions
    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :failure, credit_card_expiration_date: Time.now)
    @se.transactions.create(id:1, invoice_id: 2, credit_card_number: 2, result: :failure, credit_card_expiration_date: Time.now)
    assert_equal 0, @sa.revenue_from_invoices(@se.invoices.all)
  end

  def test_revenue_from_invoices_returns_correctly_when_successful_transactions_on_one_invoice
    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 2, item_id: 2, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    assert_equal 100_000_00, @sa.revenue_from_invoices(@se.invoices.all)
  end

  def test_revenue_from_invoices_returns_correctly_when_successful_transactions_on_multiple_invoices
    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 2, item_id: 2, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.transactions.create(id:1, invoice_id: 2, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    assert_equal 200_000_00, @sa.revenue_from_invoices(@se.invoices.all)
  end


  def test_unsuccessful_invoices
    @se.invoices.create(id: 1123, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.transactions.create(id:2, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    actual = @sa.unsuccessful_invoices
    assert_equal 1, actual.size
    assert_equal 1123, actual[0].id
  end

  def test_an_invoice_is_paid_in_full
    setup_big_data_set
    actual = @sa.invoice_paid_in_full?(1)
    assert_equal true, actual

    actual = @sa.invoice_paid_in_full?(200)
    assert_equal true, actual

    actual = @sa.invoice_paid_in_full?(203)
    assert_equal false, actual

    actual = @sa.invoice_paid_in_full?(204)
    assert_equal false, actual
  end
end
