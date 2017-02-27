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
require_relative '../test/file_hash_setup'

class RepositoryTest < Minitest::Test

  include FileHashSetup

  attr_reader :file_hash, :se, :path, :repo, :repository

  def setup
    super
    @path = 'test/fixtures/merchant_sample_small.csv'
    @repo = Repository.new(se, path, Merchant)
  end

  def test_it_loads_a_repository
    assert_equal Array, repo.load_file.class
    assert_equal  Merchant, repo.klass
  end

  def test_load_file_item
    assert_equal Array, repo.load_file.class
    refute_empty repo.load_file
  end
end
