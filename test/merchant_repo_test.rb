require './test/test_helper'
require './lib/merchant_repo'
require './lib/merchant'
require 'csv'

class MerchantRepoTest < Minitest::Test

  def setup
      @merchants = CSV.open './data/test_merchants.csv',
                        headers: true,
                        header_converters: :symbol
      @mr = MerchantRepo.new
  end

  def test_exists
    assert_instance_of MerchantRepo, @mr
  end

  def test_initializes_as_empty
    assert_equal [], @mr.all
  end

  def test_it_can_load_items
    @mr.load_merchants(@merchants)
    assert_equal 9, @mr.all.length
  end

  def test_it_can_find_by_id
    @mr.load_merchants(@merchants)

    assert_instance_of Merchant, @mr.find_by_id(12334105)
    assert_equal "Shopin1901", @mr.find_by_id(12334105).name
  end

  def test_it_can_find_by_name
    @mr.load_merchants(@merchants)

    assert_instance_of Merchant, @mr.find_by_name("Shopin1901")
    assert_equal "12334105", @mr.find_by_name("shopin1901").id
  end

  def test_it_can_find_all_by_name
    @mr.load_merchants(@merchants)

    assert_equal 2, @mr.find_all_by_name("Shopin1901").length
    assert_equal [], @mr.find_all_by_name("notvalidname")
  end

  def test_it_can_create_new_merchant
    @mr.load_merchants(@merchants)
    @mr.create({:name => "test merch"})

    assert_equal 10, @mr.all.length
    assert_equal 12334145, @mr.all.last.id
  end

  def test_it_can_update_merchant_name
    @mr.load_merchants(@merchants)
    @mr.update(12334105, "changed merch name")

    assert_equal "changed merch name", @mr.find_by_id(12334105).name
  end

  def test_it_can_delete_by_id
    @mr.load_merchants(@merchants)
    @mr.delete(12334105)

    assert_equal 8, @mr.all.length
    assert_nil @mr.find_by_id(12334105)

  end

end
