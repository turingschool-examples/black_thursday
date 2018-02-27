require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

# tests for invoice item repository class
class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @repo = InvoiceItemRepository.new('./test/fixtures/invoice_items.csv',
                                      'parent')
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @repo
    assert_equal       'parent', @repo.parent
  end

  def test_it_has_invoice_items
    assert_instance_of Array,       @repo.all
    assert_equal 20,                @repo.all.length
    assert_instance_of InvoiceItem, @repo.all[0]
    assert_nil                      @repo.load_invoice_items('./test/fixtures/invoice_items.csv')
  end

  def test_inspect
    assert_equal "#<InvoiceItemRepository 20 rows>", @repo.inspect
  end

  def test_find_by_id
    assert_nil                      @repo.find_by_id(12_345)
    assert_instance_of InvoiceItem, @repo.find_by_id(1)
  end

  def test_find_all_by_item_id
    assert_equal [],                @repo.find_all_by_item_id(12_345)
    assert_instance_of InvoiceItem, @repo.find_all_by_item_id(263519844)[0]
  end

  def test_find_by_invoice_id
    assert_equal [],                @repo.find_all_by_invoice_id(12_345)
    assert_instance_of InvoiceItem, @repo.find_all_by_invoice_id(1)[0]
  end
end
