require_relative '../test/test_helper'
require_relative '../lib/invoices_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoice

  def setup
    @invoice = InvoiceRepository.new("data/invoices_fixtures.csv")
  end

  def test_it_exists
    # skip
    assert invoice
  end

  def test_find_by_id_returns_correct_invoice
    # add real number below
    result = @invoice.find_by_id(00000)
    assert_equal Invoices, result.class
    # add real number below
    assert_equal 00000, result.id
  end

  def test_find_all_by_customer_id
    add real number below
    result = @invoice.find_all_by_customer_id(00000)
    assert_equal #invoice instance
    , result
  end




end
