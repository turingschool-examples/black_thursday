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

    assert_equal 10, invr.all.length
  end

  def test_if_find_by_id_returns_correct_value_for_method
    invr = InvoiceRepository.new(@files)

    assert_equal invr.all[0], invr.find_by_id(1)
    assert_nil invr.find_by_id(13)
  end
end
