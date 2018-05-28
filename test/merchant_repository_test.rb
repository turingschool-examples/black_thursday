require_relative 'test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    @merchant_repository = @se.merchants
    require 'pry'; binding.pry
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  # def test_merchant_repo_holds_all_instances_of_merchants
  #   assert_equal 475, @merchant_repository.all.length
  # end

end
