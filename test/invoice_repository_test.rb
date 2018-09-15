require './test/minitest_helper'
require_relative '../lib/invoice_repository'
require 'CSV'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_r = InvoiceRepository.new('./test/fixtures/invoices_fixtures.csv')
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_r
  end

  def test_all_returns_an_array_of_all_invoices
    assert_equal 14, @invoice_r.all.count
  end
end
