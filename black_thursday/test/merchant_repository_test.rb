require_relative 'test_helper'
require 'csv'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchants,
              :repository

  def setup
    @repository = MerchantRepository.new("./data/merchants.csv")
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @repository    
  end

  def test_it_can_return_all_merchants
    assert_equal repository.merchants, @repository.all
  end



end
