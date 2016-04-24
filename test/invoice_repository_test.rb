require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :ir

  def setup
    test_helper = TestHelper.new.invoices
    @ir = InvoiceRepository.new(test_helper)
  end

  def test_it_can_be_instantiated
    assert ir
  end

  def test_it_can_create_invoices_class
    assert_equal Invoice, ir.all[0].class
  end

  def test_it_can_create_invoices
    assert_equal 3, ir.all.count
  end

  def test_it_can_find_an_item_by_its_id
    assert_equal 7, ir.find_by_id(7).id
  end

  def test_it_can_find_all_invoices_by_merchant_id
    assert_equal 1, ir.find_all_by_merchant_id(9).count
  end

  def test_it_can_find_invoices_by_customer_id
    assert_equal 1, ir.find_all_by_merchant_id(11).count
  end

  def test_it_can_find_all_invoices_by_customer_id
    assert_equal 2, ir.find_all_by_customer_id(8).count
  end

  def test_it_can_find_all_invoices_by_status
    assert_equal :pending, ir.find_all_by_status("pending")[0].status
  end


end
