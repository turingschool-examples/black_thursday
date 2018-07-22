require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/merchant.rb'
require_relative '../lib/sales_engine.rb'

class MerchantRepositoryTest < Minitest::Test 
  
  def test_it_exists 
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
     })
    mr = MerchantRepository.new(csv_hash[:merchants])
    
    assert_instance_of MerchantRepository, mr 
  end 
  
  # def test_it_creates_merchants
    
end 