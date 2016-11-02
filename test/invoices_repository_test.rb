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


end
