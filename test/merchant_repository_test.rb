require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test

    def setup
      @mr = MerchantRepository.new("./data/merchant_test.csv")
    end

    def test_it_exists
      assert_instance_of MerchantRepository, @mr
    end

    def test_it_returns_all_merchants
      assert_equal 12334105, @mr.all[0].id
      assert_equal 12334123, @mr.all[4].id
      assert_equal 5, @mr.all.size
    end

    def test_it_can_find_merchants_by_id
      assert_nil @mr.find_by_id(24)
      assert_equal @mr.all[4], @mr.find_by_id(12334123)
    end

    def test_it_can_find_merchants_by_name
      assert_nil @mr.find_by_name("Frank")
      assert_equal @mr.all[0] , @mr.find_by_name("Shopin1901")
      assert_equal @mr.all[4], @mr.find_by_name("Keckenbauer")
      assert_equal @mr.all[2], @mr.find_by_name("MiNiaTureBikEz")
    end

    def test_it_can_find_all_merchants_by_name_fragment
      assert_equal [], @mr.find_all_by_name("Bob")
      assert_equal [@mr.all[0], @mr.all[2]], @mr.find_all_by_name("in")
      assert_equal [@mr.all[0], @mr.all[2]], @mr.find_all_by_name("iN")
    end

    def test_it_creates_new_merchant
      new_merchant = @mr.create({name: "Dave"})
      assert_equal 12334124, new_merchant.id
      assert_equal "Dave", new_merchant.name
    end
    #
    def test_it_can_update_merchant_attributes
      @mr.update(12334113, {name: "Joe"})
      assert_equal 12334113, @mr.all[2].id
      assert_equal "Joe", @mr.all[2].name
    end
    #
    def test_it_can_delete_merchants
      merchant = @mr.all[0]
      @mr.delete(12334105)
      refute @mr.all.include? merchant
    end

    def test_it_populates_array_from_filepath
      new_merchant = MerchantRepository.new("./data/merchant_test.csv")

      assert_instance_of Merchant, new_merchant.all[0]
      assert_equal 5, new_merchant.all.size
      assert_equal 12334105, new_merchant.all[0].id
      assert_equal "Candisart", new_merchant.all[1].name
      # assert_equal "2010-03-30", new_merchant.all[2].created_at
    end

end
