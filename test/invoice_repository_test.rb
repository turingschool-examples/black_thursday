require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/item'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :file_hash, :se, :path, :repo, :invoice_repository

  def setup
    @file_hash = {
      invoices: './data/invoices.csv',
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    }
    @path = 'test/fixtures/invoice_sample.csv'
    @se = SalesEngine.from_csv(file_hash)
    @repo = Repository.new(se, path, Invoice)
    @invoice_repository = InvoiceRepository.new(se, path)
  end

  def test_it_finds_all_items
    assert_equal Array, invoice_repository.all.class
    refute_empty invoice_repository.all
  end

  def test_find_by_id
      assert_equal Invoice , invoice_repository.find_by_id(1).class
  end


  def test_find_all_by_customer_id
    assert_equal Array, invoice_repository.find_all_by_customer_id(1).class
  end

  def test_find_all_by_merchant_id
    assert_equal Array, invoice_repository.find_all_by_merchant_id(12335938).class
  end


  def test_find_all_by_status
    assert_equal Array, invoice_repository.find_all_by_status("shipped").class
  end


end
