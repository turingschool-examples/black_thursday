require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :ir

  def setup
    @ir = InvoiceItemRepository.new("./test/data/invoice_items_truncated.csv", self)
  end

  def test_invoice_item_repo_instantiates
    assert_equal InvoiceItemRepository, @ir.class
  end

  def test_invoice_item_repo_opens_csv_into_array
    assert_equal Array, @ir.all_invoice_item_data.class
  end


end
