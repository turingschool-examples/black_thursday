require_relative 'test_helper'
require './lib/item_repository'
require 'pry'
require 'csv'
require 'date'
require 'bigdecimal'

class InvoiceRepositoryTest < Minitest:: Test
  def test_it_exists
    i_repository = InvoiceRepository.new

    assert_instance_of InvoiceRepository, i_repository
  end
  def test_it_can_return_all_invoices
    i_repository = InvoiceRepository.new
    i_repository.create_invoice( "./data/invoices.csv")

    assert_equal 4985, i_repository.all.count
  end

  def test_it_can_find_invoice_by_id
    i_repository = InvoiceRepository.new
    i_repository.create_invoice("./data/invoices.csv")
    result=  i_repository.find_by_id(6)
    assert_equal "6", result.id
  end

  def test_it_can_find_by_customer_id
    skip
    i_repository = InvoiceRepository.new
    i_repository.create_invoice( "./data/invoices.csv")

    assert_equal 23, i_repository.find_all_by_customer_id(7)
  end
  def test_it_can_find_by_merchant_id
    skip
    i_repository = InvoiceRepository.new
    i_repository.create_invoice( "./data/invoices.csv")

    assert_equal 23 , i_repository.find_all_by_merchant_id(8)
  end
  def test_it_can_find_by_status
    skip
    i_repository = InvoiceRepository.new
    i_repository.create_invoice("./data/invoices.csv")

    assert_equal 23, i_repository.find_all_by_status("pending")
  end



end

#
# all - returns an array of all known Invoice instances
# find_by_id - returns either nil or an instance of Invoice with a matching ID
# find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
# find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
# find_all_by_status - returns either [] or one or more matches which have a matching status
