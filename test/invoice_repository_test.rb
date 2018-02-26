require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require_relative './master_hash'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    sales_engine = SalesEngine.new(test_engine)
    @invoice_repository = sales_engine.invoices
  end

  def test_it_exists
    invoice_repository = @invoice_repository

    assert_instance_of InvoiceRepository, invoice_repository
  end

  def test_invoice_repository_holds_all_invoices
    invoice_repository = @invoice_repository

    assert_equal 65, invoice_repository.all.length
    assert (invoice_repository.all.all? { |invoice| invoice.is_a?(Invoice)})
  end

  def test_invoice_repository_holds_invoice_attributes
    invoice_repository = @invoice_repository

    assert_equal 1, invoice_repository.all.first.id
    assert_equal 12335938, invoice_repository.all.first.merchant_id
  end

  def test_it_can_find_invoice_by_id
    invoice_repository = @invoice_repository

    result = invoice_repository.find_by_id(7)

    result_nil = invoice_repository.find_by_id(99)

    assert_instance_of Invoice, result
    assert_equal 1, result.customer_id
    assert_equal 12_334_135, result.merchant_id
    assert_nil result_nil
  end

  def test_it_can_find_all_invoices_by_customer_id
    invoice_repository = @invoice_repository

    result = invoice_repository.find_all_by_customer_id(1)

    result_nil = invoice_repository.find_all_by_customer_id(12)

    assert_instance_of Array, result
    assert result.length == 8
    assert_equal 3, result[2].id
    assert_equal 12_335_955, result[2].merchant_id
    assert result_nil.empty?
  end


  def test_it_can_find_all_invoices_by_merchant_id
    invoice_repository = @invoice_repository

    result = invoice_repository.find_all_by_merchant_id(12_335_955)

    result_nil = invoice_repository.find_all_by_merchant_id(666)

    assert_instance_of Array, result
    assert result.length == 13
    assert result_nil.empty?
  end

  def test_it_can_find_all_invoices_by_status
    invoice_repository = @invoice_repository

    result = invoice_repository.find_all_by_status('pending')

    result_nil = invoice_repository.find_all_by_status('in space')

    assert_instance_of Array, result
    assert result_nil.empty?
  end

  def test_it_can_go_to_sales_engine_with_id
    iv = @invoice_repository
    result_merchant = iv.invoice_repo_finds_merchant_via_engine(3)
    result_items = iv.invoice_repo_finds_items_via_engine(2)
    result_customer = iv.invoice_repo_finds_customer_via_engine(1)

    assert_instance_of Merchant, result_merchant[0]
    assert_instance_of Item, result_items[0]
    assert_instance_of Customer, result_customer
  end

  def test_finds_transactions_and_evaluates_via_engine
    iv = @invoice_repository
    result = iv.invoice_repo_finds_transactions_and_evaluates_via_engine(46)

    assert result
  end

  def test_invoice_total_returns_cost_for_paid_invoice
    iv = @invoice_repository
    result = iv.invoice_repo_finds_invoice_items_total_via_engine(46)
    unpaid_result = iv.invoice_repo_finds_invoice_items_total_via_engine(14)

    assert_equal BigDecimal.new(986.68, 5), result
    assert_nil unpaid_result
  end

  def test_invoice_transactions_returns_transactions
    result = @invoice_repository.invoice_repo_finds_transactions_via_engine(2779)

    assert_equal 19, result[0].id
    assert_equal 4318767847968505, result[0].credit_card_number
  end
end
