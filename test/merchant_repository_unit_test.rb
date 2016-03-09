require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  def setup

    @sample = [{:id => 12334105, :name => "Shopin1901", :created_at => "2010-12-10", :updated_at => "2011-12-04" }, {:id => 12334112, :name => "Candisart", :created_at => "2009-05-30", :updated_at => "2010-08-29"}]

    @merchant_1 = Merchant.new(SalesEngine.new,@sample[0])

    @merchant_2 = Merchant.new(SalesEngine.new,@sample[1])

    @merchant_1_inspect = "id: 12334105,\nname: Shopin1901,\ncreated_at: 2010-12-10,\nupdated_at: 2011-12-04"

    @merchant_2_inspect = "id: 12334112,\nname: Candisart,\ncreated_at: 2009-05-30,\nupdated_at: 2010-08-29"

    @merchant_1_inspect_find_all = "[id: 12334105,\nname: Shopin1901,\ncreated_at: 2010-12-10,\nupdated_at: 2011-12-04]"

    @mr = MerchantRepository.new(SalesEngine.new)

    @repository = @sample.map do |merchant|
      Merchant.new(SalesEngine.new, merchant)
    end

    @mr.repository = @repository
  end

  def test_merchant_repository_can_be_instantiated
    assert @mr
    assert_equal MerchantRepository, @mr.class
  end

  def test_merchant_repository_can_find_merchant_by_id
    assert_equal @merchant_1_inspect, @mr.find_by_id(12334105).inspect
    assert_equal @merchant_2_inspect, @mr.find_by_id(12334112).inspect
  end

  def test_merchant_repository_can_find_merchant_by_name_case_insensitive
    mr = MerchantRepository.new(SalesEngine.new)
    assert_equal @merchant_1_inspect, @mr.find_by_name("Shopin1901").inspect
    assert_equal @merchant_1_inspect, @mr.find_by_name("shopin1901").inspect
    assert_equal @merchant_2_inspect, @mr.find_by_name("Candisart").inspect
    assert_equal @merchant_2_inspect, @mr.find_by_name("candIsArt").inspect
    assert_equal nil, @mr.find_by_name("Girls Rule the World Shop")
  end

  def test_merchant_repository_can_find_all_merchants_by_name
    assert_equal @merchant_1_inspect_find_all, @mr.find_all_by_name("SHoP").inspect
    assert_equal [], @mr.find_all_by_name("Girls Rule the World")
  end

  def test_merchant_repository_can_return_all_merchant_instances
    assert_equal @repository, @mr.all
  end

  def test_can_find_merchants_with_pending_invoices
    assert_equal 467, @mr.merchants_with_failed_transaction
  end

end
