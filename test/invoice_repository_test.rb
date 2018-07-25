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
end
