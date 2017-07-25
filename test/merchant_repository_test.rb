require_relative 'test_helper'
require './lib/merchant_repository'
require './lib/merchant'
require 'pry'

class MerchantRepositoryTest < Minitest::Test
  def test_that_merchant_repo_class_exist
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_load_csv_file
    mr = MerchantRepository.new("./data/merchants.csv")
    assert mr
  end
end
