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
end
