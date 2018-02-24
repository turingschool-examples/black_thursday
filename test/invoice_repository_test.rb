require_relative 'test_helper.rb'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine.rb'
require_relative './master_hash.rb'

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

    assert_equal 14, invoice_repository.all.length
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

    result_nil = invoice_repository.find_by_id(21)

    assert_instance_of Invoice, result
    assert_equal 1, result.customer_id
    assert_equal 12335009, result.merchant_id
    assert_nil result_nil
  end

  def test_it_can_find_all_invoices_by_customer_id
    invoice_repository = @invoice_repository

    result = invoice_repository.find_all_by_customer_id(1)

    result_nil = invoice_repository.find_all_by_customer_id(6)

    assert_instance_of Array, result
    assert result.length == 8
    assert_equal 3, result[2].id
    assert_equal 12_335_955, result[2].merchant_id
    assert result_nil.empty?
  end


  def test_it_can_find_all_invoices_by_merchant_id
    invoice_repository = @invoice_repository

    result = invoice_repository.find_all_by_merchant_id(12335955)

    result_nil = invoice_repository.find_all_by_merchant_id(666)

    assert_instance_of Array, result
    assert result.length == 2
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
    # result_merchant = iv.invoice_repo_finds_merchant_via_engine(1)
    result_items = iv.invoice_repo_finds_items_via_engine(1)
    result_customer = iv.invoice_repo_finds_customer_via_engine(1)

    # assert_instance_of Merchant, result[0]
    # ^^ comment in after fixture data is updated
    assert_instance_of InvoiceItem, result_items[0]
    assert_instance_of Customer, result_customer
  end

  def test_finds_transactions_and_evaluates_via_engine
    iv = @invoice_repository
    result = iv.invoice_repo_finds_transactions_and_evaluates_via_engine(46)

    assert result
  end

  def test_invoice_total_returns_cost_for_paid_invoice
    invoice = @invoice_repository
    result = iv.invoice_repo_finds_invoice_items_cost_if_paid(46)

    assert 986.68, result
  end
end
