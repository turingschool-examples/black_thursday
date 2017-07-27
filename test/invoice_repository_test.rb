require './test/test_helper'
require './lib/invoice_repository.rb'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    inr = InvoiceRepository.new('./data/invoices_short.csv', self)

    assert_instance_of InvoiceRepository, inr
  end

  def test_it_can_return_array_of_all_invoices
    inr = InvoiceRepository.new('./data/invoices_short.csv', self)

    target = inr.all

    assert_equal 11, target.count
    assert_equal Array, target.class
  end

  def test_it_can_find_by_id
    inr = InvoiceRepository.new('./data/invoices_short.csv', self)

    target = inr.find_by_id(6)
    target_2 = inr.find_by_id(00000000)

    assert_equal 1, target.customer_id
    assert_equal Invoice, target.class
    assert_nil target_2
  end

  def test_it_can_find_all_by_customer_id
    inr = InvoiceRepository.new('./data/invoices_short.csv', self)

    target = inr.find_all_by_customer_id(1)
    target_2 = inr.find_all_by_customer_id(9999)

    assert_equal 12335938, target[0].merchant_id
    assert_equal Array, target.class
    assert_equal [], target_2
  end

  def test_it_can_find_all_by_merchant_id
    inr = InvoiceRepository.new('./data/invoices_short.csv', self)

    target = inr.find_all_by_merchant_id(12334105)
    target_2 = inr.find_all_by_merchant_id(123)

    assert_equal 1, target.count
    assert_equal Array, target.class
    assert_equal [], target_2
  end

  def test_it_can_find_all_by_status
    inr = InvoiceRepository.new('./data/invoices_short.csv', self)

    target = inr.find_all_by_status(:returned)
    target_2 = inr.find_all_by_status("nil")

    assert_equal 1, target.count
    assert_equal Array, target.class
    assert_equal [], target_2
  end
end