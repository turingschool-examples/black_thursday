require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test

    def setup
      # @merchant_1 = Merchant.new({id: 5, name: 'Steve'})
      # @merchant_2 = Merchant.new({id: 10, name: 'Turing School'})
      # @merchant_3 = Merchant.new({id: 7, name: 'Turk'})
      # @merchants = [@merchant_1, @merchant_2, @merchant_3]
      @mr = MerchantRepository.new("./data/merchant_test.csv")
    end

    def test_it_exists
      assert_instance_of MerchantRepository, @mr
    end

    def test_it_returns_all_merchants
      assert_equal "12334105", @mr.all[0].id
      assert_equal "12334123", @mr.all[4].id
      assert_equal 5, @mr.all.size
    end
    #
    # def test_it_can_find_merchants_by_id
    #   assert_nil @mr.find_by_id(24)
    #   assert_equal @merchant_1, @mr.find_by_id(5)
    # end
    #
    # def test_it_can_find_merchants_by_name
    #   assert_nil @mr.find_by_name("Frank")
    #   assert_equal @merchant_1, @mr.find_by_name("Steve")
    #   assert_equal @merchant_2, @mr.find_by_name("turing school")
    # end
    #
    # def test_it_can_find_all_merchants_by_name_fragment
    #   assert_equal [], @mr.find_all_by_name("Bob")
    #   assert_equal [@merchant_2, @merchant_3], @mr.find_all_by_name("Tur")
    #   assert_equal [@merchant_2, @merchant_3], @mr.find_all_by_name("tur")
    # end
    #
    # def test_it_creates_new_merchant
    #   new_merchant = @mr.create({name: "Dave"})
    #   assert_equal 11, new_merchant.id
    #   assert_equal "Dave", new_merchant.name
    # end
    #
    # def test_it_can_update_merchant_attributes
    #   @mr.update(5, {name: "Joe"})
    #   assert_equal 5, @merchant_1.id
    #   assert_equal "Joe", @merchant_1.name
    # end
    #
    # def test_it_can_delete_merchants
    #   @mr.delete(5)
    #   refute @mr.all.include? @merchant_1
    # end
    #
    # def test_it_populates_array_from_filepath
    #   new_merchant = MerchantRepository.new("./data/merchants_test.csv")
    #
    #   assert_instance_of Merchant, new_merchant.all[0]
    #   assert_equal 5, new_merchant.all.size
    #   assert_equal 12334105, new_merchant.all[0].id
    #   assert_equal "Candisart", new_merchant.all[1].name
    #   # assert_equal "2010-03-30", new_merchant.all[2].created_at
    # end

end
