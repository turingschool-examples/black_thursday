require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

# SalesFactory
class RepositoryTest < Minitest::Test

  def test_load_file
    path = 'test/fixtures/merchant_sample_small.csv'
    repo = Repository.new(path, Merchant)
    assert_equal Array, repo.load_file
    assert_equal  Merchant , repo.load_file.first.class
  end

end
