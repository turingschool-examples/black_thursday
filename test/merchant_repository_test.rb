# frozen_string_literal:true

require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repository = MerchantRepository.new('./data/test_merchants.csv')
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  # def test_generating_merchant_data_array
  #   expected = [%w[id name created_at updated_at],
  #               %w[12334105 Shopin1901 2010-12-10 2011-12-04],
  #               %w[12334112 Candisart 2009-05-30 2010-08-29],
  #               %w[12334113 MiniatureBikez 2010-03-30 2013-01-21],
  #               %w[12334115 LolaMarleys 2008-06-09 2015-04-16],
  #               %w[12334123 Keckenbauer 2010-07-15 2012-07-25],
  #               %w[12334132 perlesemoi 2009-03-21 2014-05-19],
  #               %w[12334135 GoldenRayPress 2011-12-13 2012-04-16]]
  #   assert_equal expected, @merchant_repository.generate_merchants_data('./data/test_merchants.csv')
  # end

  def test_creating_an_index_of_merchants_from_data
    assert_instance_of Hash, @merchant_repository.by_id
    assert_instance_of Merchant, @merchant_repository.by_id['12334105']
    assert_instance_of Merchant, @merchant_repository.by_id['12334112']
    assert_instance_of Merchant, @merchant_repository.by_id['12334113']
    assert_instance_of Merchant, @merchant_repository.by_id['12334115']
    assert_instance_of Merchant, @merchant_repository.by_id['12334123']
    assert_instance_of Merchant, @merchant_repository.by_id['12334132']
    assert_instance_of Merchant, @merchant_repository.by_id['12334135']
  end
end
