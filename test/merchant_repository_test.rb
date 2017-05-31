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





end
