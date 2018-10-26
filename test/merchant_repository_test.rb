require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test

    def setup
      # @mr = MerchantRepository.new("./data/merchant_test.csv")
      @merchant_1 = Merchant.new({id: 5, name: 'Steve'})
      @merchant_2 = Merchant.new({id: 10, name: 'Turing School'})
      @merchant_3 = Merchant.new({id: 7, name: 'Turk'})
      @merchants = [@merchant_1, @merchant_2, @merchant_3]
      @mr = MerchantRepository.from_objects(@merchants)
    end

    def test_it_exists
      assert_instance_of MerchantRepository, @mr
    end

    def test_it_returns_all_merchants
      assert_equal 5, @mr.all[0].id
      assert_equal 7, @mr.all[2].id
      assert_equal 3, @mr.all.size
    end

    def test_it_can_find_merchants_by_id
      assert_nil @mr.find_by_id(24)
      assert_equal @mr.all[1], @mr.find_by_id(10)
    end

    def test_it_can_find_merchants_by_name
      assert_nil @mr.find_by_name("Frank")
      assert_equal @mr.all[0] , @mr.find_by_name("Steve")
      assert_equal @mr.all[2], @mr.find_by_name("Turk")
      assert_equal @mr.all[2], @mr.find_by_name("TURk")
    end

    def test_it_can_find_all_merchants_by_name_fragment
      assert_equal [], @mr.find_all_by_name("Bob")
      assert_equal [@mr.all[1], @mr.all[2]], @mr.find_all_by_name("Tur")
      assert_equal [@mr.all[1], @mr.all[2]], @mr.find_all_by_name("tuR")
    end

    def test_it_creates_new_merchant
      new_merchant = @mr.create({name: "Dave"})
      assert_equal 11, new_merchant.id
      assert_equal "Dave", new_merchant.name
    end

    def test_it_can_update_merchant_attributes
      @mr.update(10, {name: "Joe"})
      assert_equal 10, @mr.all[1].id
      assert_equal "Joe", @mr.all[1].name
    end

    def test_it_can_delete_merchants
      merchant = @mr.all[1]
      @mr.delete(10)
      refute @mr.all.include? merchant
    end

end
