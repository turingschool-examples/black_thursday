require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/item'


class RepositoryTest < Minitest::Test

  def test_load_file_merchant
    path = 'test/fixtures/merchant_sample_small.csv'
    repo = Repository.new(path, Merchant)
    require "pry"; binding.pry
    assert_equal Array, repo.load_file.class

    assert_equal  Merchant , repo.klass
  end

  # def test_load_file_item
  #   path = 'test/fixtures/items_sample.csv'
  #   repo = Repository.new(path, Item)
  #   assert_equal Array, repo.load_file.class
  #
  #   assert_equal  Item , repo.klass
  # end

end
