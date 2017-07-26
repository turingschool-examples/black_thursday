require_relative 'test_helper'
require './lib/invoice_repository'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_exist
    ir = InvoiceRepository.new("./data/mini_invoices.csv")
    assert_instance_of InvoiceRepository, ir
  end

  def test_it_can_load_csv_file
    ir = InvoiceRepository.new("./data/mini_invoices.csv")
    assert ir
  end

  def test_all_can_return_an_instance_of_invoice
    ir = InvoiceRepository.new("./data/mini_invoices.csv")
    assert_equal 2, ir.all.count
  end

  def test_invoice_repo_is_able_to_find_by_id
    ir = InvoiceRepository.new("./data/mini_invoices.csv")
    assert ir.find_by_id(1)
  end

  def test_it_can_find_all_by_customer_id
    ir = InvoiceRepository.new("./data/mini_invoices.csv")
    assert ir.find_all_by_customer_id(1)
  end

  def test_it_can_find_all_by_merchant_id
    ir = InvoiceRepository.new("./data/mini_invoices.csv")
    assert ir.find_all_by_merchant_id(12335938)
    binding.pry
  end
end
