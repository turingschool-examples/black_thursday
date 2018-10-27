require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    iir = InvoiceItemRepository.new('./test/data/invoice_item_sample.csv')
    assert_instance_of InvoiceItemRepository, iir
  end

  def test_invoice_item_repo_has_repository_array_and_returns_all
    iir = InvoiceItemRepository.new('./test/data/invoice_item_sample.csv')
    assert_equal 10, iir.all.count
    assert_instance_of Array, iir.all
  end

  def test_it_can_find_by_invoice_item_by_id
    iir = InvoiceItemRepository.new('./test/data/invoice_item_sample.csv')
    item = iir.repo_array[1]
    assert_equal item, iir.find_by_id(2)
  end

  def test_find_all_by_item_id
    iir = InvoiceItemRepository.new('./test/data/invoice_item_sample.csv')
    assert_equal 4, iir.find_all_by_item_id(2).count
  end






end
