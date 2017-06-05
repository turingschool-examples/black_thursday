require 'pry'
require 'csv'
require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @files = './test/data/invoice_items_test.csv'
  end

  def test_it_creates_class
    iir = InvoiceItemRepository.new(@files)

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_initialize_and_population_of_items
    iir = InvoiceItemRepository.new(@files)

    assert_equal 11, iir.all.length
  end

  def test_if_find_by_id_returns_correct_value_for_method
    iir = InvoiceItemRepository.new(@files)

    assert_equal iir.all[0], iir.find_by_id(1)
    assert_nil iir.find_by_id(13)
  end

  def test_find_all_by_item_id
    iir = InvoiceItemRepository.new(@files)

    actual_1 = iir.find_all_by_item_id(263454779)
    actual_2 = iir.find_all_by_item_id(22)

    assert_equal 1, actual_1.length
    assert_equal [], actual_2
  end

  def test_find_all_by_invoice_id
    iir = InvoiceItemRepository.new(@files)

    actual_1 = iir.find_all_by_invoice_id(1)
    actual_2 = iir.find_all_by_invoice_id(122)

    assert_equal 8, actual_1.length
    assert_equal [], actual_2

  end

end
