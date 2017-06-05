require 'pry'
require 'csv'
require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @files = './test/data/invoices_test.csv'
  end

  def test_if_create_class
    invr = InvoiceRepository.new(@files)

    assert_instance_of InvoiceRepository, invr
  end

  def test_initialize_and_population_of_items
    invr = InvoiceRepository.new(@files)

    assert_equal 12, invr.all.length
  end

  def test_if_find_by_id_returns_correct_value_for_method
    invr = InvoiceRepository.new(@files)

    assert_equal invr.all[0], invr.find_by_id(1)
    assert_nil invr.find_by_id(13)
  end

  def test_find_all_by_customer_id
    invr = InvoiceRepository.new(@files)

    actual_1 = invr.find_all_by_customer_id(1)
    actual_2 = invr.find_all_by_customer_id(22)

    assert_equal 10, actual_1.length
    assert_equal [], actual_2
  end

  def test_if_find_all_by_merchant_id_works
    invr = InvoiceRepository.new(@files)

    actual_1 = invr.find_all_by_merchant_id(12335938)
    actual_2 = invr.find_all_by_merchant_id(22)

    assert_equal 2, actual_1.length
    assert_equal [], actual_2
  end

  def test_if_find_all_by_status_works
    invr = InvoiceRepository.new(@files)

    actual_1 = invr.find_all_by_status(:returned)
    actual_2 = invr.find_all_by_status(:pending)
    actual_3 = invr.find_all_by_status(:shipped)

    assert_equal 1, actual_1.length
    assert_equal 7, actual_2.length
    assert_equal 4, actual_3.length
  end
end
