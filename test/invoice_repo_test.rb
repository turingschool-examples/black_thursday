require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test
  attr_reader :ir

  def setup
    @ir = InvoiceRepo.new("./data/invoices.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceRepo, ir
  end

  def test_find_all_invoices
    assert_equal 4985, ir.all_invoices.count
  end

  def test_find_by_id
    # assert_instance_of Invoice, ir.find_by_id(12337139)
    assert_equal 8, ir.find_by_id(12337139).id
  end

  # def test_find_all_by_customer_id
  #   assert_equal 23, ir.find_all_by_customer_id(customer_id).count
  # end
end
