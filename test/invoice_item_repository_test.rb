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

  def test_it_returns_invoice_item_instances
    assert_equal InvoiceItem, @ir.all[1].class
  end

  def test_it_can_return_ids
    actual = @ir.find_by_id(6)
    expected = @ir.all[5]

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_item_id
    actual = @ir.find_all_by_item_id(263454779)
    expected = [@ir.all[1]]

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_invoice_id
    actual = @ir.find_all_by_invoice_id(1).count

    assert_equal 8, actual
  end
end
