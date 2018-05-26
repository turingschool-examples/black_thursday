require './lib/salesengine'
require './lib/merchantrepository'
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new
    assert_instance_of MerchantRepository, mr
  end

  def test_all
    mr = MerchantRepository.new
    assert_equal [], mr.all
  end

  def test_find_by_id
    mr = MerchantRepository.new
    assert_equal nil, mr.find_by_id("12334105")
  end

end
