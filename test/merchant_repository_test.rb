require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @merchant_1 = Merchant.new({:id => 5, :name => "Turing School"})
    @merchant_2 = Merchant.new({:id => 7, :name => "G School"})
    @merchant_3 = Merchant.new({:id => 9, :name => "Denver University"})
    @merchants = [@merchant_1, @merchant_2, @merchant_3]
    @merchant_repository = MerchantRepository.new(@merchants)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_returns_all_merchants
    expected = [@merchant_1, @merchant_2, @merchant_3]
    actual = @merchant_repository.all

    assert_equal expected, actual
  end

  def test_it_finds_merchant_by_id
    assert_equal nil, @merchant_repository.find_by_id(2)
    assert_equal @merchant_2, @merchant_repository.find_by_id(7)
  end

  def test_it_finds_merchant_by_name
    assert_equal nil, @merchant_repository.find_by_name("CU")
    assert_equal @merchant_2, @merchant_repository.find_by_name("G School")
  end

  def test_if_finds_merchant_by_name_fragment
    assert_equal [], @merchant_repository.find_all_by_name("Orange")
    assert_equal [@merchant_1, @merchant_2], @merchant_repository.find_all_by_name("scho")
  end

  def test_it_creates_new_merchant
    @merchant_repository.create({:id => 3, :name => "Denver Coding School"})
    assert_equal 4, @merchant_repository.all.count
    assert_equal "Denver Coding School", @merchant_repository.all.last.name
  end

  def test_new_merchant_has_highest_id_number
    @merchant_repository.create({:id => 3, :name => "Denver Coding School"})
    assert_equal 10, @merchant_repository.all.last.id
  end

end
