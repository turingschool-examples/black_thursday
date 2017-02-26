require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'


class RepositoryTest < Minitest::Test

  def test_load_file_merchant
    file_hash = {
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv'
    }
    path = 'test/fixtures/merchant_sample_small.csv'
    se = SalesEngine.from_csv(file_hash)
    repo = Repository.new(se, path, Merchant)

    assert_equal Array, repo.load_file.class

    assert_equal  Merchant, repo.klass
  end

  # def test_load_file_item
  #   path = 'test/fixtures/items_sample.csv'
  #   repo = Repository.new(path, Item)
  #   assert_equal Array, repo.load_file.class
  #
  #   assert_equal  Item , repo.klass
  # end

end
