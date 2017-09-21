require './test/test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repository

  def setup
    @invoice_item_repository = InvoiceItemRepository.new("./data/invoice_items.csv")
  end

  def test_that_it_exists
    assert_instance_of InvoiceItemRepository, invoice_item_repository
  end

  def test_find_by_id_returns_inv_item_match
    expected = invoice_item_repository.find_by_id(10)

    assert_equal 10, expected.id
    assert_equal 263523644, expected.item_id
    assert_equal 2, expected.invoice_id
  end

  def test_find_by_id_can_return_empty
    expected = invoice_item_repository.find_by_id(200000)

    assert_nil expected
  end

  def test_find_all_by_item_id_returns_matches_array
    expected = invoice_item_repository.find_all_by_item_id(263408101)

    assert_equal 11, expected.length
    assert_instance_of InvoiceItem, expected.first
  end

  def test_find_all_by_item_id_returns_empty
    expected = invoice_item_repository.find_all_by_item_id(10)

    assert_equal 0, expected.length
    assert expected.empty?
  end

  def test_find_all_by_invoice_id_returns_all_matches
    expected = invoice_item_repository.find_all_by_invoice_id(100)

    assert_equal 3, expected.length
    assert_instance_of InvoiceItem, expected.first
  end

  def test_find_all_by_invoice_id_returns_empty
    expected = invoice_item_repository.find_all_by_invoice_id(1234567890)

    assert_equal 0, expected.length
    assert expected.empty?
  end
end
