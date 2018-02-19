require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @merchant_repo = MerchantRepository.new('./test/fixtures/merchants_sample.csv')
  end

  def test_if_it_exists
    assert_instance_of MerchantRepository, @merchant_repo
  end

  def test_if_merchant_repository_has_merchants
    assert_instance_of Array, @merchant_repo.all
    assert_equal 7, @merchant_repo.all.count
    assert @merchant_repo.all.all? { |merchant| merchant.is_a?(Merchant)}
  end

  def test_if_it_can_load_correct_ids
    assert_equal 12334141, @merchant_repo.all.first.id
    assert_equal 12334213, @merchant_repo.all[4].id
  end

  def test_if_it_can_load_correct_names
    assert_equal "jejum", @merchant_repo.all.first.name
    assert_equal "MuttisStrickwaren", @merchant_repo.all[4].name
  end

  def test_it_can_find_a_merchant_by_id
    result = @merchant_repo.find_by_id(12334141)

    assert_instance_of Merchant, result
    assert_equal "jejum", result.name
    assert_equal 12334141, result.id
  end

  def test_it_can_find_another_merchant_by_id
    result = @merchant_repo.find_by_id(12334315)

    assert_instance_of Merchant, result
    assert_equal "Soudoveshop", result.name
    assert_equal 12334315, result.id
  end

  def test_it_can_return_nil_when_there_is_no_match_for_id
    result = @merchant_repo.find_by_id(32334388)

    assert_nil result
  end

  def test_it_can_find_a_merchant_by_name
    result = @merchant_repo.find_by_name("jejum")

    assert_instance_of Merchant, result
    assert_equal "jejum", result.name
    assert_equal 12334141, result.id
  end

  def test_it_can_find_another_merchant_by_name
    result = @merchant_repo.find_by_name("Soudoveshop")

    assert_instance_of Merchant, result
    assert_equal "Soudoveshop", result.name
    assert_equal 12334315, result.id
  end

  def test_it_can_find_a_merchant_by_name_that_is_upcase
    result = @merchant_repo.find_by_name("SOUDOVESHOP")

    assert_instance_of Merchant, result
    assert_equal "Soudoveshop", result.name
    assert_equal 12334315, result.id
  end

  def test_it_can_find_a_merchant_by_name_case_insenstive
    result = @merchant_repo.find_by_name("SOUdoVeSHOP")

    assert_instance_of Merchant, result
    assert_equal "Soudoveshop", result.name
    assert_equal 12334315, result.id
  end

  def test_it_can_return_nil_when_there_is_no_match_for_name
    result = @merchant_repo.find_by_name("Mike Dao's Shop")

    assert_nil result
  end

end
