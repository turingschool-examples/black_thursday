require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require 'pry'


class MerchantRepositoryTest < Minitest::Test
    attr_reader :repository

  def setup
    @repository = MerchantRepository.new('fixture/merchant_test_file.csv')
  end

  def test_it_can_create_merchant_repository
    @repository
  end

  def test_it_can_find_all_instances_of_Merchant
    skip
  end


  def test_it_can_find_by_id
    assert @repository.id(1234105)
    assert_instance_of Merchant, repository.id(1234105)
    assert @repository.id(12334112)
    assert_instance_of Merchant, repository.id(12334112)
    assert_nil @repository.id(12345678)
  end

  def test_it_can_find_by_case_insensitive_name
    assert_instance_of Merchant, @repository.name("shopin1901")
    assert_instance_of Merchant, @repository.name("SHOPIN1901")
    assert_instance_of Merchant, @repository.name("Shopin1901")
    assert_instance_of Merchant, @repository.name("candisart")
    assert_instance_of Merchant, @repository.name("CANDISART")
    assert_instance_of Merchant, @repository.name("Candisart")
    assert nil, repository.name("Amazon")
  end

  def test_it_can_find_all_by_case_insensitive_name

    assert_instance_of Merchant, @repository.name("shop")
    assert_instance_of Merchant, @repository.name("SHOPIN")
    assert_instance_of Merchant, @repository.name("1901")
    assert_instance_of Merchant, @repository.name("CANDI")
    assert_instance_of Merchant, @repository.name("Art")
    assert_instance_of Merchant, @repository.name("sart")
    assert nil, repository.name("Amazon")
  end
end
