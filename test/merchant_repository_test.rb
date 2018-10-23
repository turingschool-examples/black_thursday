require './test/test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @mr = MerchantRepository.new
    @merchant_1 = Merchant.new({:id => 12334123, :name => "Keckenbauer"})
    @merchant_2 = Merchant.new({:id => 12334145, :name => "BowlsByChris"})
    @merchant_3 = Merchant.new({:id => 12334159, :name => "SassyStrangeArt"})
    @mr.add_merchant(@merchant_1)
    @mr.add_merchant(@merchant_2)
    @mr.add_merchant(@merchant_3)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_can_store_merchants
    expected = [@merchant_1, @merchant_2, @merchant_3]
    assert_equal expected, @mr.all
  end

  def test_it_can_find_merchant_by_id
    assert_equal @merchant_2, @mr.find_by_id(12334145)
  end

  def test_find_merchant_by_name
    assert_equal @merchant_3, @mr.find_by_name("SassyStrangeArt")
  end

  def test_it_can_add_new_merchant_from_attributes
    name = "Big D's Watches"
    expected_id = 12334160
    expected_merchant = Merchant.new({id: expected_id, name: name})
    @mr.create(name)
    assert_equal expected_merchant.id, @mr.all.last.id
    assert_equal expected_merchant.name, @mr.all.last.name
  end

end
