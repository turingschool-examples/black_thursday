require_relative 'test_helper.rb'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_exists
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')

    assert_instance_of InvoiceRepository, invoice_repository
  end

  def test_invoice_repository_holds_all_invoices
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')

    assert_equal 14, invoice_repository.all.count
    assert (invoice_repository.all.all? { |invoice| invoice.is_a?(Invoice)})
  end

  def test_invoice_repository_holds_invoice_attributes
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')

    assert_equal 1, invoice_repository.all.first.id
    assert_equal 12335938, invoice_repository.all.first.merchant_id
  end

  def test_it_can_find_invoice_by_id
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')

    result = invoice_repository.find_by_id(7)

    result_nil = invoice_repository.find_by_id(21)

    assert_instance_of Invoice, result
    assert_equal 1, result.customer_id
    assert_equal 12335009, result.merchant_id
    assert_nil result_nil
  end

  def test_it_can_find_all_invoices_by_customer_id
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')

    result = invoice_repository.find_all_by_customer_id(1)

    result_nil = invoice_repository.find_all_by_customer_id(6)

    assert_instance_of Array, result
    assert result.length == 8
    assert_equal 3, result[2].id
    assert_equal 12_335_955, result[2].merchant_id
    assert_nil result_nil
  end


  def test_it_can_find_all_invoices_by_merchant_id
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')

    result = invoice_repository.find_all_by_merchant_id(12335955)

    result_nil = invoice_repository.find_all_by_merchant_id(666)

    assert_instance_of Array, result
    assert result.length == 2
    assert result_nil.empty?
  end

  def test_it_can_find_all_invoices_by_status
    invoice_repository = InvoiceRepository.new('./test/fixtures/invoices.csv')

    result = invoice_repository.find_all_by_status('pending')

    result_nil = invoice_repository.find_all_by_status('in space')

    assert_instance_of Array, result
    assert result.length == 8
    assert result_nil.empty?
  end
end
