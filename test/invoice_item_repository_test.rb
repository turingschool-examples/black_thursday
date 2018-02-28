require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'
require_relative './master_hash'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    sales_engine = SalesEngine.new(test_engine)
    @invoice_item_repository = sales_engine.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_item_repository
  end

  def test_invoice_item_repository_can_hold_items
    assert_equal 31, @invoice_item_repository.all.count
    assert (@invoice_item_repository.all.all? { |inv_i| inv_i.is_a?(InvoiceItem)})
  end

  def test_it_can_find_invoice_item_by_id
    result = @invoice_item_repository.find_by_id(8)

    result_nil = @invoice_item_repository.find_by_id(1_989)

    assert_instance_of InvoiceItem, result
    assert_equal 8, result.id
    assert_nil result_nil
  end

  def test_it_can_find_all_invoice_items_by_item_id
    result = @invoice_item_repository.find_all_by_item_id(263_529_264)

    result_nil = @invoice_item_repository.find_all_by_item_id(55)

    assert_equal 2, result.length
    assert_instance_of InvoiceItem, result[0]
    assert result_nil.empty?
  end

  def test_it_can_find_all_invoice_items_by_invoice_id
    result = @invoice_item_repository.find_all_by_invoice_id(1)

    result_nil = @invoice_item_repository.find_all_by_invoice_id(1_989)

    assert_equal 8, result.length
    assert_instance_of InvoiceItem, result[0]
    assert result_nil.empty?
  end

  def test_inspect
    exp_result = "#<InvoiceItemRepository 31 rows>"
    assert_equal exp_result, @invoice_item_repository.inspect
  end
end
