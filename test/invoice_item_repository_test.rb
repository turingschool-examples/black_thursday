require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_pull_csv
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items_fixture.csv')
    assert_instance_of CSV, iir.pull_csv
  end

  def test_parse_csv
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items_fixture.csv')
    assert_instance_of InvoiceItem, iir.invoice_items_array[0]
  end

  def test_all
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items_fixture.csv')
    assert_equal 100, iir.all.count
  end

  def test_all
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items_fixture.csv')
    assert_equal 100, iir.find_by_id(100).id
    assert_nil iir.find_by_id(101)
  end

  def test_find_all_by_item_id
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items_fixture.csv')
    assert_equal 1,  iir.find_all_by_item_id(263454779).count
  end

  def test_find_all_by_invoice_id
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items_fixture.csv')
    assert_equal 8, iir.find_all_by_invoice_id(1).count
  end
end
