require_relative 'test_helper'
require_relative '../lib/merchant_repo'

class MerchantRepoTest < Minitest::Test
  attr_reader :mr

  def setup
    @mr = MerchantRepo.new("./data/merchants.csv")
  end

  def test_it_exists
    assert_instance_of MerchantRepo, mr
  end

  def test_it_returns_all
    assert_equal 475, mr.all.count
    assert_instance_of Array, mr.all
    assert_instance_of Merchant, mr.all.sample
  end

  def test_it_returns_nil_if_there_is_no_id
    assert_nil mr.find_by_id(5)
  end

  def test_it_finds_merchant_by_id
    expected = "TheCullenChronicles"
    assert_equal expected, mr.find_by_id(12336927).name
  end

  def test_it_returns_nil_without_name
    assert_nil mr.find_by_name('Turing School')
  end

  def test_it_finds_one_merchant_by_name
    assert_equal Merchant, mr.find_by_name("Shopin1901").class
  end

  def test_it_can_find_all_merchant_by_name
    assert_equal 1, mr.find_all_by_name("Shopin1901").count
  end

  def test_find_max_id
    assert_equal 12337412, mr.find_max_id
  end

  def test_it_can_create
    attrs = {name: 'BreadCo'}

    merchant =  mr.create(attrs).last
    assert_instance_of Merchant, merchant
    assert_equal 'BreadCo', merchant.name
    assert_instance_of Time, merchant.created_at
    assert_instance_of Time, merchant.updated_at
  end

  def test_it_can_update_a_merchant
    attrs_1 = {name: 'BreadCo'}
    merchant = mr.create(attrs_1).last
    attrs_2 = {name: 'Bread Shop'}
    id = merchant.id
    mr.update(id, attrs_2)

    assert_equal 'Bread Shop', merchant.name
    assert_equal "2018-04-11", merchant.updated_at

  end

  def test_it_can_delete_a_merchant
    attrs_1 = {name: 'BreadCo'}
    merchant = mr.create(attrs_1).last
    id = merchant.id
    mr.delete(id)
    refute mr.all.include?(merchant)
  end
end
