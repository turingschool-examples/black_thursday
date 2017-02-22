require 'minitest/autorun'
require 'minitest/pride'
require 'simplecov'
require 'pry'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_1, :merchant_2, :merchant_3, :merch_repo
  def setup
    @merchant_1 = Merchant.new({:id =>12334105, :name => 'Shopin1901'})
    @merchant_2 = Merchant.new({:id => 12334112, :name => 'Candisart'})
    @merchant_3 = Merchant.new({:id => 12334113, :name => 'MiniatureBikez'})
    @merch_repo = MerchantRepository.new('./data/merchants_test_data.csv')
  end

  def test_Repository_exists
    assert_instance_of MerchantRepository, merch_repo
  end

  def create_merchants
    merch_repo
    assert_equal [{:id=>"12334105", :name=>"Shopin1901", :created_at=>"2010-12-10", :updated_at=>"2011-12-04"},
                {:id=>"12334112", :name=>"Candisart", :created_at=>"2009-05-30", :updated_at=>"2010-08-29"},
                {:id=>"12334113", :name=>"MiniatureBikez", :created_at=>"2010-03-30", :updated_at=>"2013-01-21"}],
    merch_repo.create_csv_hash
  end


  def test_all_merchants_array
    merch_repo
    csv_hash = merch_repo.create_merchants

    assert_equal [{:id=>"12334105", :name=>"Shopin1901", :created_at=>"2010-12-10", :updated_at=>"2011-12-04"},
                {:id=>"12334112", :name=>"Candisart", :created_at=>"2009-05-30", :updated_at=>"2010-08-29"},
                {:id=>"12334113", :name=>"MiniatureBikez", :created_at=>"2010-03-30", :updated_at=>"2013-01-21"}],
   merch_repo.all(csv_hash)
  end


end
