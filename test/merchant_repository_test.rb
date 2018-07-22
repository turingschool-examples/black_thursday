require_relative '../test/test_helper.rb'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repo = MerchantRepository.new('./data/merchants.csv')
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repo
  end

  def test_it_has_somewhere_to_store_merchants
    assert_instance_of Array, @merchant_repo.merchants
  end

  def test_it_can_load_merchants_from_csv
    refute @merchant_repo.merchants.empty?
  end

  def test_it_can_return_all_merchants
    assert_equal @merchant_repo.merchants, @merchant_repo.all
  end

  def test_it_can_find_a_merchant_by_id
    assert_equal @merchant_repo.merchants[0], @merchant_repo.find_by_id(12334105)
  end

  def test_it_can_find_a_merchant_by_name
    assert_equal @merchant_repo.merchants[0], @merchant_repo.find_by_name("Shopin1901")
  end

  def test_it_find_all_by_name_fragment
    assert_equal 26, @merchant_repo.find_all_by_name("shOp").count
  end

  def test_it_can_create_merchants
    assert_equal 475, @merchant_repo.merchants.count
    @merchant_repo.create({:name => "Sour Creamery"})
    assert_equal 476, @merchant_repo.merchants.count
  end

  def test_it_can_update_attributes
    @merchant_repo.update(12334105, {:name => "Sour Creamery"})
    sour_creamy = @merchant_repo.find_by_id(12334105)
    assert_equal "Sour Creamery", sour_creamy.name
  end

  def test_it_can_delete_a_merchant
    assert_instance_of Merchant, @merchant_repo.find_by_id(12334105)
    @merchant_repo.delete(12334105)
    assert_nil @merchant_repo.find_by_id(12334105)
  end
end
