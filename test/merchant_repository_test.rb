require 'minitest/autorun'
require 'minitest/pride'
require_relative './merchant_repository.rb'
require_relative './merchant.rb'
require_relative './sales_engine.rb'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/dummy_items.csv",
    :merchants => "./data/dummy_merchants.csv",
     })
    mr = MerchantRepository.new(se.csv_hash[:merchants])

    assert_instance_of MerchantRepository, mr
  end

  def test_it_creates_merchants
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    mr = MerchantRepository.new(se.csv_hash[:merchants])
    mr.create_all_from_csv("./data/dummy_merchants.csv")
    assert_equal  4 , mr.all.count
  end

  def test_it_finds_by_id
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    mr = MerchantRepository.new(se.csv_hash[:merchants])
    mr.create_all_from_csv("./data/dummy_merchants.csv")
    assert_equal Merchant, mr.find_by_id("12334115").class
  end

  def test_find_by_name
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    mr = MerchantRepository.new(se.csv_hash[:merchants])
    mr.create_all_from_csv("./data/dummy_merchants.csv")
    assert_equal mr.all[3], mr.find_by_name("LolaMarleys")
  end

  def test_find_all_by_name
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    mr = MerchantRepository.new(se.csv_hash[:merchants])
    mr.create_all_from_csv("./data/dummy_merchants.csv")
    assert_equal [mr.all[1]], mr.find_all_by_name("Candisart")
  end

  def test_find_highest_id
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    mr = MerchantRepository.new(se.csv_hash[:merchants])
    mr.create_all_from_csv("./data/dummy_merchants.csv")
    assert_equal mr.all[3], mr.find_highest_id
  end

  def test_create
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    mr = MerchantRepository.new(se.csv_hash[:merchants])
    mr.create_all_from_csv("./data/dummy_merchants.csv")
    mr.create({:name => "Donald's"})
    assert_equal 5 , mr.all.count#mr.all[4], mr.all.count
  end

    def test_update
      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
      })
      mr = MerchantRepository.new(se.csv_hash[:merchants])
      mr.create_all_from_csv("./data/dummy_merchants.csv")
      original_merchant = mr.find_by_id("12334113")
      assert_equal "MiniatureBikez"  , original_merchant.name
      mr.update("12334113", {:name => "DogBikez" })
      assert_equal "DogBikez", mr.find_by_id("12334113").name
    end

    def test_delete
      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
      })
      mr = MerchantRepository.new(se.csv_hash[:merchants])
      mr.create_all_from_csv("./data/dummy_merchants.csv")
      mr.delete("12334112")
      assert_nil mr.find_by_id("12334112")
    end
end
