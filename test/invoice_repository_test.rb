require_relative 'test_helper'
require_relative '../lib/invoice_repository.rb'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_repository = InvoiceRepository.new("./data/invoices.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repository
  end

  def test_it_can_hold_invoices
    assert_instance_of Array, @invoice_repository.invoices
  end

  def test_its_holding_invoices
    assert_instance_of Invoice, @invoice_repository.invoices[0]
    assert_instance_of Invoice, @invoice_repository.invoices[25]
  end

  def test_it_can_return_items_using_all
    assert_instance_of Invoice, @invoice_repository.all[5]
    assert_instance_of Invoice, @invoice_repository.all[97]
  end

  def test_it_can_find_by_id
    expected = @invoice_repository.invoices[0]
    actual = @invoice_repository.find_by_id(1)
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_customer_id
    expected = 8
    actual = @invoice_repository.find_all_by_customer_id(1).count
    assert_equal expected, actual
  end
end
