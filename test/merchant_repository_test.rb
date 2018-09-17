require_relative 'test_helper'

require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test

  def setup
    path = {:merchants => './data/merchants.csv'}
    @repo = SalesEngine.from_csv(path).merchants

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

    def test_it_gets_attributes
      # --- Read Only ---
      assert_instance_of Array, @repo.all
      assert_instance_of Merchant, @repo.all[0]
      assert_equal @repo.all.count, @repo.all.uniq.count
      assert_equal 475, @repo.all.count
    end


    # --- Find By ---

    def test_it_can_find_by_merchant_id
      # -- no results --
      not_found = @repo.find_by_id(000)
      assert_nil not_found
      # -- results --
      found = @repo.find_by_id(12334105)
      assert_equal @merchant1.id, found.id
      found = @repo.find_by_id(12334112)
      assert_equal @merchant2.id, found.id
    end

    def test_it_can_find_by_merchant_name
      # -- no results --
      not_found = @repo.find_by_id("zzzz")
      assert_nil not_found
      # -- results --
      found = @repo.find_by_name("Shopin1901")
      assert_equal @merchant1.name, found.name
      found = @repo.find_by_name("Candisart")
      assert_equal @merchant2.name, found.name
    end

    def test_it_can_find_from_a_string_fragment
      # -- no results --
      not_found = @repo.find_all_by_name("zzzzz")
      assert_equal [], not_found
      # -- results --
      found1 = @repo.find_all_by_name("pi")
      found2 = @repo.find_all_by_name("PI")
      found3 = @repo.find_all_by_name("Pi")
      found4 = @repo.find_all_by_name("pI")
      tests = found1 == found2 && found1 == found3 && found1 == found4
      assert_equal true, tests
      assert_instance_of Array, found1
      assert_instance_of Merchant, found1[0]
      assert_equal false, found1[0].name.downcase == "pi"
      assert_equal true, found1[0].name.include?("pi")
    end

    def test_it_can_CREATE_new_merchant
      
      assert_equal 475, @repo.all.count

      @repo.create( {name: "GeoffX"} ) 

      assert_equal 476, @repo.all.count
      assert_equal "GeoffX", @repo.all.last.name
      assert_equal 12337412, @repo.all.last.id
    end
  
    def test_it_can_UPDATE_existing_merchants
      assert_equal 475, @repo.all.count
      hash = {name: "GeoffX Plush Toys"}

      @repo.update(12337411, hash)
      entry = @repo.find_by_id(12337411)
      assert_equal "GeoffX Plush Toys", entry.name
      assert_equal 475, @repo.all.count
      hash = {name: "RachelNose Pliers"}
      @repo.update(12337411, hash)
      entry = @repo.find_by_id(12337411)
      assert_equal "RachelNose Pliers", entry.name
      assert_equal 475, @repo.all.count
    end
  
    def test_it_can_DELETE_existing_merchants
      @repo.delete(263395237)
      assert_nil @repo.find_by_id(263395237)
    end

end
