require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_1 = Merchant.new({:id => 5, :name => "Turing School", :created_at => Time.now, :updated_at => Time.now})
    @merchant_2 = Merchant.new({:id => 7, :name => "G School", :created_at => Time.now, :updated_at => Time.now})
    @merchant_3 = Merchant.new({:id => 9, :name => "Denver University", :created_at => Time.now, :updated_at => Time.now})
    @merchants = [@merchant_1, @merchant_2, @merchant_3]
    @merchant_repository = MerchantRepository.new(@merchants)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_returns_all_merchants
    expected = @merchants
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
    @merchant_repository.create({:name => "Denver Coding School", :created_at => Time.now, :updated_at => Time.now})
    assert_equal 4, @merchant_repository.all.count
    assert_instance_of Merchant, @merchant_repository.all.last
    assert_equal "Denver Coding School", @merchant_repository.all.last.name
  end

  def test_new_merchant_has_highest_id_number
    @merchant_repository.create({:id => 3, :name => "Denver Coding School", :created_at => Time.now, :updated_at => Time.now})

    assert_equal 10, @merchant_repository.all.last.id
  end

  def test_attributes_can_be_updated
    @merchant_repository.update(7, {:id => 3, :name => "Galvanize"})

    assert_equal "Galvanize", @merchant_2.name
    assert_equal 7, @merchant_2.id
  end

  def test_merchant_can_be_deleted
    @merchant_repository.create({:id => 3, :name => "Denver Coding School", :created_at => Time.now, :updated_at => Time.now})

    assert_equal 4, @merchant_repository.all.count

    @merchant_repository.delete(10)

    assert_equal 3, @merchant_repository.all.count
    assert_equal nil, @merchant_repository.find_by_name("Denver Coding School")
  end
end
