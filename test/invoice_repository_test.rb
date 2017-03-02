require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @path = "./data/invoices_fixture.csv"
    @ir = InvoiceRepository.new(@path, self)
  end

  def test_it_exist
    invoice_repository = InvoiceRepository.new(@path, self)
    assert_instance_of InvoiceRepository, invoice_repository
  end

  def test_can_return_all_invoice_items
    assert_equal 30, @ir.all.length
  end

  def test_can_find_by_id
    found = @ir.find_by_id(7)
    not_found = @ir.find_by_id(9999999)
    assert_equal 7, found.id
    assert_nil not_found
  end

  def test_can_find_all_by_customer_id
    found = @ir.find_all_by_customer_id(1)
    not_found = @ir.find_all_by_customer_id(999999)
    assert_equal 1, found[0].customer_id
    assert_equal [], not_found
  end

  def test_can_find_all_by_merchant_id
    found = @ir.find_all_by_merchant_id(12335938)
    not_found = @ir.find_all_by_merchant_id(999999)
    assert_equal 12335938, found[0].merchant_id
    assert_equal [], not_found
  end

  def test_can_find_by_status
    found = @ir.find_all_by_status(:pending)
    not_found = @ir.find_all_by_status(:remitted)
    assert_equal 10, found.length
    assert_equal 0, not_found.length
  end
end