require './test/test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @se= SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv",
      :invoices  => "./data/dummy_invoices.csv",
      :invoice_items => "./data/dummy_invoice_items.csv",
      :transactions =>"./data/dummy_transactions.csv",
      :customers => "./data/dummy_customers.csv" })
    @mr = MerchantRepository.new(@se.csv_hash[:merchants])
    @mr.create_all_from_csv("./data/dummy_merchants.csv")
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_creates_merchants
    assert_equal  4, @mr.all.count
    assert_equal Merchant, @mr.all[0].class
  end

  def test_it_finds_by_id
    assert_equal Merchant, @mr.find_by_id(12334115).class
  end

  def test_find_by_name
    assert_equal @mr.all[3], @mr.find_by_name("LolaMarleys")
  end

  def test_find_all_by_name
    assert_equal [@mr.all[1]], @mr.find_all_by_name("Candisart")
  end

  def test_find_highest_id
    assert_equal @mr.all[3], @mr.find_highest_id
  end

  def test_create
    @mr.create({:name => "Donald's"})
    assert_equal 5, @mr.all.count
  end

  def test_update
    original_merchant = @mr.find_by_id(12334113)
    assert_equal "MiniatureBikez", original_merchant.name
    @mr.update(12334113, {:name => "DogBikez" })
    assert_equal "DogBikez", @mr.find_by_id(12334113).name
  end

  def test_delete
    @mr.delete(12334112)
    assert_nil @mr.find_by_id(12334112)
  end
end
