require './test/test_helper'
require './lib/invoice_repository'
require 'csv'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :inv_r

  def setup
    fixture = CSV.open('./test/fixtures/invoices_fixture.csv',
                          headers: true,
                          header_converters: :symbol)
    csv_rows = fixture.to_a
    @inv_r = InvoiceRepository.new(csv_rows)
  end

  def test_method_invoices_returns_array_of_invoices
    assert_instance_of Array, inv_r.invoices
    assert_equal true, inv_r.invoices.all? { |thing| thing.class == Invoice }
  end

  def test_method_all_returns_array_of_invoices
    assert_equal inv_r.invoices, inv_r.all
  end

  def test_method_find_by_id_returns_nil_or_invoice
    invoice =     inv_r.find_by_id(1)
    invoice_nil = inv_r.find_by_id(9001)
    assert_instance_of Invoice, invoice
    assert_equal 1,          invoice.id
    assert_equal nil,        invoice_nil
  end

  def test_method_find_all_by_customer_id_returns_array_of_invoices
    invoices = inv_r.find_all_by_customer_id(100)
    invoices_multiple = inv_r.find_all_by_customer_id(200)
    invoices_empty = inv_r.find_all_by_customer_id(9000..9001)
    assert_equal 100, invoices[0].customer_id
    assert_equal true, invoices_multiple.length > 1
    assert_equal [], invoices_empty
  end

  def test_method_find_all_by_merchant_id_returns_array_of_invoices
    invoices = inv_r.find_all_by_merchant_id(1000)
    invoices_multiple = inv_r.find_all_by_merchant_id(1001)
    invoices_empty = inv_r.find_all_by_merchant_id(9000..9001)
    assert_equal 1000, invoices[0].merchant_id
    assert_equal true, invoices_multiple.length > 1
    assert_equal [], invoices_empty
  end

  def test_method_find_all_by_status_returns_array_of_invoices
    invoices = inv_r.find_all_by_status(:delivered)
    invoices_multiple = inv_r.find_all_by_status(:shipped)
    invoices_empty = inv_r.find_all_by_status(:terminated)
    assert_equal :delivered, invoices[0].status
    assert_equal true, invoices_multiple.length > 1
    assert_equal [], invoices_empty
  end

  def test_method_find_merchant_by_id_returns_merchant
    mock_se = Minitest::Mock.new
    inv_r = InvoiceRepository.new([], mock_se)
    mock_se.expect(:find_merchant_by_id, nil, [1000])
    inv_r.find_merchant_by_id(1000)
    assert mock_se.verify
  end
end
