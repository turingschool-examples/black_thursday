require_relative 'test_helper'

require './lib/merchant_repository'
require './lib/merchant'
require './lib/finderclass'

class MerchantRepositoryTest < Minitest::Test

  def setup
    # these tests might break with specharness / require relative
    @path = './data/merchants.csv'
    @repo = MerchantRepository.new(@path)

    # -- from CSV --
    # 12334105,Shopin1901,2010-12-10,2011-12-04
    # 12334112,Candisart,2009-05-30,2010-08-29
    merch1_data = {:name => "Shopin1901", :created_at => "2010-12-10", :updated_at => "2011-12-04"}
    merch2_data = {:name => "Candisart", :created_at => "2009-05-30", :updated_at => "2010-08-29"}
    merch1 = {:"12334105" => merch1_data }
    merch2 = {:"12334112" => merch2_data}

    @merchant1 = Merchant.new( {id: 12334105, name: "Shopin1901"} )
    @merchant2 = Merchant.new( {id: 12334112, name: "Candisart"} )
  end

    def test_it_exists
      assert_instance_of MerchantRepository, @repo
    end

    def test_it_can_make_all_merchants
      merch = @repo.all.first(100)
      assert_equal 100, merch.count
      assert_equal 100, merch.uniq.count
      assert_equal 12334105, merch[0].id
      assert_equal "Shopin1901", merch[0].name
    end

    def test_it_gets_all_merchants
      assert_equal 475, @repo.all.count
    end

    def test_it_can_find_by_merchant_id
      found = @repo.find_by_id(12334105)
      assert_equal @merchant1.id, found.id
      found = @repo.find_by_id(12334112)
      assert_equal @merchant2.id, found.id
    end

    def test_it_can_find_by_merchant_name
      found = @repo.find_by_name("Shopin1901")
      assert_equal @merchant1.name, found.name
      found = @repo.find_by_name("Candisart")
      assert_equal @merchant2.name, found.name
    end

    def test_it_can_find_from_a_string_fragment
      found1 = @repo.find_all_by_name("pi")
      found2 = @repo.find_all_by_name("PI")
      found3 = @repo.find_all_by_name("Pi")
      found4 = @repo.find_all_by_name("pI")
      test1 = found1 == found2
      test2 = found2 == found3
      test3 = found3 == found4
      assert_equal true, test1 && test2 && test3
      assert_instance_of Array, found1
      assert_instance_of Merchant, found1[0]
      assert_equal true, found1[0].name.include?("pi")
      not_found = @repo.find_all_by_name("zzzzz")
      assert_equal [], not_found
    end






end
