require './test/test_helper'
require './lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository

  def setup
    @merchant_repository = MerchantRepository.new("data/merchants_fixture.csv")
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
    result = merchant_repository.all[0].id
    assert_equal 12334105, result
  end

  def test_find_by_id_finds_correct_pair_of_values
    merchant_repository.all
    result = merchant_repository.find_by_id(12334105).name
    assert_equal "shopin1901", result
  end

  def test_find_by_id_returns_correct_format
    merchant_repository.all
    result = merchant_repository.find_by_id(12334105)
    assert_equal Merchant, result.class
  end

  def test_find_by_name_finds_correct_pair_of_values
    merchant_repository.all
    result = merchant_repository.find_by_name("Shopin1901")
    assert_equal 12334105, result.id
    assert_equal "shopin1901", result.name
    assert_equal Merchant, result.class
  end

  def test_find_all_by_name_nil_case
    result = merchant_repository.find_all_by_name(nil)
    assert_equal "Steve the Pirate", result
  end

  def test_find_all_by_name_returns_array_of_names
    merchant_repository.all
    result = merchant_repository.find_all_by_name("Shopin")
    # binding.pry
    assert_equal "shopin1901", result.name
  end

end
