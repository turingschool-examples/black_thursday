require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository

  def setup
    @merchant_repository = MerchantRepository.new('data/merchants_fixture.csv')
  end

  def test_it_exists
    assert merchant_repository
  end

  def test_csv_loader_loads_files
    result = merchant_repository.csv
    assert result
  end

  def test_csv_loader_loads_to_array
    result = merchant_repository.all
    assert_equal Array, result.class
  end

  def test_csv_loader_loads_correctly
    result = merchant_repository.all[0][0]
    assert_equal 12334105, result
  end



end
