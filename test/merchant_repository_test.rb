require './test/test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  include SalesEngineTestSetup

  def setup
    super
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_can_make_new_merchants
    mr = @se.merchants
    assert "12334105", mr.all.first.id
  end

  def test_returns_all_merchants
    mr = @se.merchants
    assert_equal 475, mr.all.count
    assert_instance_of Array, mr.all
    assert_instance_of Merchant, mr.all.first
  end

  def test_find_by_id
    mr = @se.merchants

    assert_instance_of Merchant, mr.find_by_id(12334105)
    assert_equal "Shopin1901", mr.find_by_id(12334105).name
    assert_nil mr.find_by_id(00000000)
  end

  def test_find_by_name
    mr = @se.merchants
    assert_instance_of Merchant, mr.find_by_name("Shopin1901")
    assert_instance_of Merchant, mr.find_by_name("SHOPIN1901")
    assert_nil mr.find_by_name("foobarbaz")
  end

  def test_find_all_by_name
    mr = @se.merchants
    assert_instance_of Array, mr.find_all_by_name("Bikez")
    assert_equal "MiniatureBikez", mr.find_all_by_name("Bikez").first.name
  end

end
