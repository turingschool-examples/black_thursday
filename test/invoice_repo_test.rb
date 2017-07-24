require_relative 'test_helper'
require_relative '../lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test
  attr_reader :ir

  def setup
    @ir = InvoiceRepo.new("../data/invoices.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceRepo, ir
  end

  def test_it_can_find_all_invoices
    assert_equal 5, ir.all
  end
end
