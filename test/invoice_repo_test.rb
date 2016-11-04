require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_repo'
require 'csv'
require 'pry'

class InvoiceRepoTest < Minitest::Test
  attr_reader :file, 
              :sales_engine

  def setup
    @file = "./data/small_invoice_file.csv"
    @sales_engine = Minitest::Mock.new
  end

  def test_it_has_a_class
    i = InvoiceRepo.new(file, sales_engine)
    assert_equal InvoiceRepo, i.class
  end

  def test_it_can_display_all_invoices
    i = InvoiceRepo.new(file, sales_engine)
    assert i.all
  end

  def test_it_can_search_by_id
    i = InvoiceRepo.new(file, sales_engine)
    assert_equal 7, i.find_by_id(7).id
  end

  def test_it_can_find_by_customer_id
    i = InvoiceRepo.new(file, sales_engine)
    assert_equal 1, i.find_all_by_customer_id(5)
  end

   def test_it_can_find_by_status
    i = InvoiceRepo.new(file, sales_engine)
    assert_equal 7, i.find_all_by_status("pending")
  end

  def test_it_can_find_by_merchant_id
    i = InvoiceRepo.new(file, sales_engine)
    assert_equal 12335938, i.find_all_by_merchant_id(12334771)
  end

end