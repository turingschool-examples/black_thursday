require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine.rb'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_that_it_exists
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    assert_instance_of InvoiceItemRepository, ii
    assert_equal 21830, ii.all.count
  end

  def test_that_it_loads_an_array_invoice_item_instances
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    assert_instance_of InvoiceItem, ii.invoice_items_array[464]
    assert_equal 21830, ii.all.count
  end
end
