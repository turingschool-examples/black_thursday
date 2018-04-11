require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repository'
require 'time'

class InvoiceRepositoryTest < Minitest::Test
  def test_exists
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)
    assert_instance_of InvoiceRepository, ir
  end
  def test_it_can_have_path
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    assert_equal './test/fixtures/invoices.csv',ir.path
  end

  def test_it_can_load_invoices_from_path_given
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    assert_equal 4985, ir.invoices.count
    assert_equal 12335938, ir.invoices.first.merchant_id
    assert_equal 1, ir.invoices.first.id
    assert_equal 1, ir.invoices.first.customer_id
  end

  def test_all_method_returns_all_invpoices
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    assert_instance_of Array, ir.invoices
    assert_equal 4985, ir.invoices.count
  end

  def test_find_by_id_returns_invoice
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    result = ir.find_by_id(1)

    assert_instance_of Invoice, result
    assert_equal 12335938, result.merchant_id
    assert_equal 1, result.customer_id
    assert_equal :pending, result.status
  end

  def test_returns_nil_if_invoice_id_not_matched
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    result = ir.find_by_id(0)

    assert_nil result
  end

  def test_it_can_find_all_invoices_by_customer_id
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    result = ir.find_all_by_customer_id(1)

    assert_equal 8, result.count
  end

  def test_it_returns_empty_array_for_invalid_customer_id
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    result = ir.find_all_by_customer_id(0)

    assert_equal [], result
  end

  def test_it_can_find_all_invoices_by_merchant_id
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    result = ir.find_all_by_merchant_id(12335938)

    assert_equal 16, result.count
  end

  def test_it_returns_empty_array_for_invalid_merchant_id
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    result = ir.find_all_by_merchant_id(0)

    assert_equal [], result
  end

  def test_it_can_find_all_invoices_by_status
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    result = ir.find_all_by_status(:pending)

    assert_equal 1473, result.count
  end

  def test_it_returns_empty_array_for_invalid_status
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    result = ir.find_all_by_status("0")

    assert_equal [], result
  end

  def test_it_can_create_new_invoice_id
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)
    assert_equal 4985, ir.invoices.count

    assert_equal 4986, ir.create_new_id
  end

  def test_it_can_create_new_invoice_object
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)
    assert_equal 4986, ir.create_new_id

    result = ir.create({:customer_id => 2, :merchant_id => 3, :status =>  "pending"})
    assert_equal 4986, result.last.id
    assert_equal :pending, result.last.status
  end

  def test_it_can_update_a_invoice
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    result = ir.find_by_id(1)
    assert_equal :pending, result.status
    assert_equal 12335938, result.merchant_id
    assert_equal 1, result.customer_id

    ir.update(1,{:status => "shipped", :merchant_id => 4, :customer_id => 7})
    result1 = ir.find_by_id(1)
    assert_equal :shipped, result1.status
    assert_equal 4, result1.merchant_id
    assert_equal 7, result1.customer_id
  end

  def test_returns_nil_it_tried_to_update_invalid_invoice
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)

    assert_nil ir.find_by_id(4986)

    result = ir.update(4986,{:status => "shipped", :merchant_id => 4, :customer_id => 7})

    assert_nil result
  end

  def test_it_can_delete_invoices_from_item_repo
    ir = InvoiceRepository.new('./test/fixtures/invoices.csv', nil)
    result = ir.find_by_id(1)

    assert_equal :pending, result.status
    assert_equal 12335938, result.merchant_id
    assert_equal 1, result.customer_id

    ir.delete(1)

    assert_nil ir.find_by_id(1)
  end
end
