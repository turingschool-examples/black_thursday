require_relative 'test_helper'
require 'csv'
require_relative './../lib/invoice_item'
require_relative './../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :repository
  
    def setup
      @repository = InvoiceItemRepository.new("./test/fixtures/truncated_invoice_items.csv")
    end

    def test_it_exists
      assert_instance_of InvoiceItemRepository, @repository
    end

    def test_it_can_return_all_invoice_items
      assert_equal repository.invoice_items, @repository.all
      assert_equal 100, repository.all.length
    end

    def test_it_can_find_invoice_by_id
      assert_equal InvoiceItem, repository.find_by_id(10).class
      assert_equal 4, repository.find_by_id(10).quantity
      assert_equal 263523644, repository.find_by_id(10).item_id
    end

    def test_find_by_id_edge_case
      assert_nil repository.find_by_id(3333333333333333)
      assert_nil repository.find_by_id("lolnotarealid")
      assert_nil repository.find_by_id("02020202020202r")
      assert_nil repository.find_by_id(nil)
    end

    def test_can_find_all_invoice_items_by_item_id
      actual = repository.find_all_by_item_id(263523644)
  
      assert_equal Array, actual.class
      assert_equal 1, actual.count
      assert_equal 2, actual.first.invoice_id
    end

    def test_find_all_by_merchant_id_returns_empty_array_when_no_match_is_found
      actual = repository.find_all_by_item_id(9898989898)
  
      assert_equal [], actual
      assert_equal [], repository.find_all_by_item_id(nil)
    end

    def test_can_find_all_invoice_items_by_invoice_id
      actual = repository.find_all_by_invoice_id(1)
  
      assert_equal Array, actual.class
      assert_equal 8, actual.count
      assert_equal 263432817, actual.last.item_id
    end

end
