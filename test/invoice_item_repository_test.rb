require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @invoice_item_repo = InvoiceItemRepository.new('./test/fixtures/invoice_items_sample.csv')
  end

  def test_if_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_item_repo
  end

  def test_inspect_method
    assert_instance_of String, @invoice_item_repo.inspect
  end

  def test_if_invoice_item_repository_has_invoice_items
    assert_instance_of Array, @invoice_item_repo.all
    assert_equal 22, @invoice_item_repo.all.count
    assert @invoice_item_repo.all.all? { |invoice_item| invoice_item.is_a?(InvoiceItem)}
  end

  def test_if_it_can_load_correct_ids
    assert_equal 1, @invoice_item_repo.all.first.id
    assert_equal 3663, @invoice_item_repo.all[14].id
  end

  def test_it_can_find_an_invoice_item_by_invoice_id
    result = @invoice_item_repo.find_by_id(3663)

    assert_instance_of InvoiceItem, result
    assert_equal 3663, result.id
    assert_equal 819, result.invoice_id
    assert_equal 5, result.quantity
  end

  def test_it_can_find_another_invoice_item_by_invoice_id
    result = @invoice_item_repo.find_by_id(5547)

    assert_instance_of InvoiceItem, result
    assert_equal 5547, result.id
    assert_equal 1250, result.invoice_id
    assert_equal 2, result.quantity
  end

  def test_it_can_return_nil_when_there_is_no_match_for_invoice_id
    result = @invoice_item_repo.find_by_id(32334388)

    assert_nil result
  end

  def test_it_can_find_all_invoice_items_by_item_id
    result = @invoice_item_repo.find_all_by_item_id(263415463)

    assert result.class == Array
    assert_equal 3, result.length
    assert_instance_of InvoiceItem, result.first
    assert_equal 3665, result.first.id
    assert_equal 819, result.first.invoice_id
    assert_equal 821, result.last.invoice_id
    assert_equal 10, result.first.quantity
    assert_equal 12, result.last.quantity
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_item_id
    result = @invoice_item_repo.find_all_by_item_id(6666666)

    assert_equal [], result
  end

  def test_it_can_find_all_invoice_items_by_invoice_id
    result = @invoice_item_repo.find_all_by_invoice_id(819)

    assert result.class == Array
    assert_equal 5, result.length
    assert_instance_of InvoiceItem, result.first
    assert_equal 3661, result.first.id
    assert_equal 3665, result.last.id
    assert_equal 819, result.first.invoice_id
    assert_equal 7, result.first.quantity
    assert_equal 10, result.last.quantity
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_invoice_id
    result = @invoice_item_repo.find_all_by_invoice_id(6666666)

    assert_equal [], result
  end

end
