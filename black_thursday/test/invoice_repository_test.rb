require_relative 'test_helper'
require 'csv'
require_relative './../lib/invoice'
require_relative './../lib/invoice_repository'
require_relative './../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_exists
    ir = InvoiceRepository.new

    assert_instance_of InvoiceRepository, ir
  end
end
