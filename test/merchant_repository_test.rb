require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :merch_repo

  def setup
    csv = CSV.open('./data/merchants.csv', headers: true, header_converters: :symbol)
    @merch_repo = MerchantRepository.new(csv)
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, merch_repo
  end

  def test_it_can_add_merchants
    csv = CSV.open('./data/merchant_sample.csv', headers: true, header_converters: :symbol)

    merch_repo.merchants.clear

    merch_repo.add(csv)
    random_merch_key = merch_repo.merchants.keys.sample

    assert_instance_of Merchant, merch_repo.merchants[random_merch_key]
  end



end
