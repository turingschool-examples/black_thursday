require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/item_repository'
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
    @repo = Repository.new(se, path, Invoice)
    @invoice__item_repository = InvoiceItemRepository.new(se, path)
  end

end
