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
    assert_equal "jejum", @merchant_repo.all.first.name
  end


end
