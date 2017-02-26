require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_item'
require_relative '../lib/merchant'
require_relative '../lib/item'


class InvoiceItemRepositoryTest < Minitest::Test

  attr_reader :file_hash, :se, :path, :repo, :invoice_item_repository

  def setup
    @file_hash = {
      invoice_items: './data/invoice_items.csv',
      invoices: './data/invoices.csv',
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    }
    @path = 'test/fixtures/invoice_items_small.csv'
    @se = SalesEngine.from_csv(file_hash)
    @repo = Repository.new(se, path, InvoiceItem)
    @invoice_item_repository = InvoiceItemRepository.new(se, path)
  end

  def test_finds_all_invoice_items
    assert_equal Array, invoice_item_repository.all.class
    refute_empty invoice_item_repository.all
  end

  def test_find_by_id
    assert_equal InvoiceItem, invoice_item_repository.find_by_id(1).class
  end

  def test_it_finds_all_by_item_id
    assert_equal Array, invoice_item_repository.find_all_by_item_id(263519844).class
    refute_empty invoice_item_repository.find_all_by_item_id(263519844)
  end

  def test_it_finds_all_by_invoice_id
    assert_equal Array, invoice_item_repository.find_all_by_invoice_id(1).class
    refute_empty invoice_item_repository.find_all_by_invoice_id(1)
  end

end
