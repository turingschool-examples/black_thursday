require_relative "test_helper"
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchants,
              :repository


  def setup
    @merchants = load_csv("./date/merchants.csv").map do |row|
      Merchant.new(row)
      @repository = MerchantRepository.new(@merchants)
    end
  end

  def test_it_can_return_all_merchants

    assert_equal @merchants, @repository.all
  end


end
