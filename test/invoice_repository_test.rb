require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :se

  def setup
    @ir = InvoiceRepository.new('./test/fixtures/invoices_truncated_10.csv')
  end

  def test_it_exists
    assert_instance of InvoiceRepository, ir
  end

  def test_ir_has_a_parent_defaulted_to_nil
    assert_nil ir.parent
  end

  def test_all_returns_array_of_all_invoices
    skip

  end



end
