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

  def test_if_find_by_id_returns_correct_value_for_method
    mr = MerchantRepository.new
    m_1 = Merchant.new({:name  =>  "Turing School",
                        :id    =>  201})
    m_2 = Merchant.new({:name  =>  "Slice Works",
                        :id    =>  405})

    mr.all << m_1
    mr.all << m_2

    actual_1 = mr.find_by_id(201)
    actual_2 = mr.find_by_id(800)

    assert_equal m_1, actual_1
    assert_nil actual_2
  end

  def test_if_find_by_name_works
    mr = MerchantRepository.new
    m_1 = Merchant.new({:name  =>  "Turing School",
                        :id    =>  201})
    m_2 = Merchant.new({:name  =>  "Slice Works",
                        :id    =>  405})

    mr.all << m_1
    mr.all << m_2

    actual_1 = mr.find_by_name("Turing School")
    actual_2 = mr.find_by_name("Mike Dao's Torture Chamber")

    assert_equal m_1, actual_1
    assert_nil actual_2
  end


end
