gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def test_invoice_repo_exists
    ir = InvoiceRepository.new('./data/invoices.csv', self)

    assert_instance_of InvoiceRepository, ir
  end

end
