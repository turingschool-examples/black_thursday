require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'
require 'csv'

class MerchantTest < Minitest:: Test
  def test_it_knows_it_came_from
    merchant_repo = MerchantRepository.new("")
    merchant_repo.create_merchant({
      :merchants     => "./test/fixtures/merchants_5lines.csv",
    })
    merchant = merchant_repo.merchants.first

    assert_equal merchant_repo, merchant.repository
  end

  

  def test_it_can_create_a_merchant
    m = Merchant.new({
              :name => "Turing School",
              :id => 5
      })
      assert_instance_of Merchant, m
  end


  # def test_it_can_find_items_belonging_to_merchant(id)
  #
  #
  # end

end
