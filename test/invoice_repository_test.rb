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


end
