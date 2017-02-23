require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_list, :merchant_repo, :merchant_example
  def setup
    ob = ObjectBuilder.new
    @merchant_list = ob.read_csv({:merchant=>"./test/fixtures/merchants_test_data.csv"})
    @merchant_repo = MerchantRepository.new(merchant_list)
    @merchant_example = merchant_list[:merchant]
    
  end

  def test_it_exists
    assert_instance_of MerchantRepository, MerchantRepository.new(merchant_list)
  end

  def test_all_merchants_array
    assert_equal merchant_list, merchant_repo.all
  end

  def test_find_by_id
    assert_equal merchant_example[0],merchant_repo.find_by_id(12334105)
  end

  def test_find_by_name
    assert_equal merchant_example[0], merchant_repo.find_by_name("Shopin1901")
  end

  def test_find_all_by_name
    assert_equal [merchant_example[0], merchant_example[3]], merchant_repo.find_all_by_name("Shopin1901")
  end 
end
