require_relative './test_helper'
require 'time'
require './lib/invoice'
require './lib/invoice_repository'
require 'csv'

class InvoiceRepositoryTest < Minitest::Test
  
  def setup
    @ir = InvoiceRepository.new("./fixture_data/invoices.csv", "engine")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of InvoiceRepository, @ir
    assert_equal 4985, @ir.all.count
  end



end