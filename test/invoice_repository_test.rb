require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

# test for item class
class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_repo = InvoiceRepository.new('./test/fixtures/truncated_invoices.csv',
                                          'parent')
  end

  def test_it_exits
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_it_has_invoices
    assert_instance_of Array, @invoice_repo.all
    assert_equal 9, @invoice_repo.all.length
    assert_instance_of Invoice, @invoice_repo.all[0]
  end


end
