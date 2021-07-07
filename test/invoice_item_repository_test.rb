require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require './lib/invoice_items_repository'
require './lib/invoice_item'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @path = './data/invoice_items.csv'
    @repo = InvoiceItemRepository.new(@path)
  end


  def test_it_exists
    assert_instance_of InvoiceItemRepository, @repo
  end 

  def test_it_gets_invoice_items
    invoice_items = @repo.all.first(100)
    assert_instance_of Array, @repo.all
    assert_equal 100, invoice_items.count
    assert_equal 100, invoice_items.uniq.count
  end
  
  
  def test_it_can_find_all
    assert_equal 21830, @repo.all.count
  end

  
end