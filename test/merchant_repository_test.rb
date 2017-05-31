require 'pry'

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < MiniTest::Test

  def test_if_create_class
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository, mr
  end

  def test_all_returns_all_instances_of_merchant
    mr = MerchantRepository.new
    m_1 = Merchant.new({:name  =>  "Turing School",
                        :id    =>  201})
    m_2 = Merchant.new({:name  =>  "Slice Works",
                        :id    =>  405})

    mr.all << m_1
    mr.all << m_2

    assert_equal [m_1, m_2], mr.all
  end

  


end
