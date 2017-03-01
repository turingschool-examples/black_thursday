require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository.rb'
require './lib/sales_engine'
require 'simplecov'
require './lib/csv_parser.rb'
SimpleCov.start

class InvoiceItemRepositoryTest < Minitest::Test
  
  include CsvParser

  attr_reader :parent

  def setup
    @parent = SalesEngine.from_csv({:invoice_items => './test/fixtures/invoice_items_three.csv'})
  end

  def test_it_exists
    data = open_file("./test/fixtures/invoice_items_three.csv")
    iir = InvoiceItemRepository.new(data, parent)

   assert_instance_of InvoiceItemRepository, iir
  end

  def test_returns_an_array_of_all_known_invoice_item
    data = open_file("./test/fixtures/invoice_items_three.csv")
    iir = InvoiceItemRepository.new(data, parent)

    assert_instance_of Array, iir.all
    assert_instance_of InvoiceItem, iir.all.first
  end

  def test_find_by_id
    data = open_file("./test/fixtures/invoice_items_three.csv")
    iir = InvoiceItemRepository.new(data, parent)

    assert_instance_of InvoiceItem, iir.find_by_id(1)
    assert_equal 263519844, iir.find_by_id(1).item_id
    assert_nil iir.find_by_id(4)
  end

  def test_find_all_by_item_id
    data = open_file("./test/fixtures/invoice_items_100.csv")
    iir = InvoiceItemRepository.new(data, parent)

    assert_equal 2, iir.find_all_by_item_id(263529264).length
    assert_equal [], iir.find_all_by_item_id(2625239764)
    assert_instance_of InvoiceItem, iir.find_all_by_item_id(263529264).first
  end

  def test_find_all_by_invoice_id
    data = open_file("./test/fixtures/invoice_items_100.csv")
    iir = InvoiceItemRepository.new(data, parent)

    assert_equal 8, iir.find_all_by_invoice_id(1).length
    assert_equal [], iir.find_all_by_invoice_id(21)
    assert_instance_of InvoiceItem, iir.find_all_by_invoice_id(1).first
  end

  def test_parent_is_instance_of_sales_engine
    se = SalesEngine.from_csv({:invoice_items => './test/fixtures/invoice_items_three.csv'})
    iir = se.invoice_items
    
    assert_instance_of SalesEngine, iir.parent
  end
end