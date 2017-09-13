require "./test/test_helper"
require_relative "merchant_repository"
require_relative "merchant"
require "csv"


class MerchantRepositoryTest < Minitest::Test

  attr_reader :mr

  def setup
    
    @mr = MerchantRepository.new(fake_se, merchant_csv)
    merchant_csv = "./test/test_data/merchants_short.csv"
  end


  def test_it_exists
    assert_instance_of MerchantRepository, mr
  end

end
