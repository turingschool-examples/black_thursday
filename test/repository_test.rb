require './test/test_helper.rb'
require './lib/repository'
require './lib/merchant_repository'
require './lib/merchant'

class RepositoryTest < Minitest::Test
  def setup
    @rep = MerchantRepository.new

    @ob1 = {name: "bob", id: 1}
    @ob2 = {name: "deb", id: 2}
    @ob3 = {name: "john", id: 3}
    @ob4 = {name: "john",  id: 4}
    @ob5 = {name: "bill",id: 5}
  end

  def create_merchants
    @rep.create(@ob1)
    @rep.create(@ob2)
    @rep.create(@ob3)
    @rep.create(@ob4)
    @rep.create(@ob5)
  end

  def test_it_exists
    assert Repository === @rep
  end

  def test_all_returns_an_empty_array_by_default
    assert_equal [], @rep.all
  end

  def test_find_by_id_returns_nil_if_no_items
    create_merchants

    assert_nil @rep.find_by_id(12)
  end

  def test_find_by_id_returns_found_instance
    create_merchants

    assert_equal Merchant.new(@ob5), @rep.find_by_id(5)
  end

  def test_find_by_name_returns_nil_if_no_items
    create_merchants

    assert_nil @rep.find_by_name("Name of something")
  end

  def test_find_by_id_returns_instance_with_name
    create_merchants

    assert_equal Merchant.new(@ob3), @rep.find_by_name("john")
  end

  def test_find_all_by_name_returns_an_empty_array_if_none_found
    create_merchants

    assert_equal [], @rep.find_all_by_name("name")
  end

  def test_find_all_by_name_returns_matched_objects_by_name
    create_merchants

    expected = [Merchant.new(@ob3), Merchant.new(@ob4)]

    assert_equal expected, @rep.find_all_by_name("john")
  end

  def test_create_adds_instances_to_array
    assert_empty @rep.all

    create_merchants

    expected = [Merchant.new(@ob1), Merchant.new(@ob2), Merchant.new(@ob3), Merchant.new(@ob4), Merchant.new(@ob5)]

    assert_equal expected, @rep.all
  end

  def test_deleting_by_id_removes_instance
    create_merchants

    expected = [Merchant.new(@ob1), Merchant.new(@ob2), Merchant.new(@ob3), Merchant.new(@ob4), Merchant.new(@ob5)]
    assert_equal expected, @rep.all

    @rep.delete(5)

    expected = [Merchant.new(@ob1), Merchant.new(@ob2), Merchant.new(@ob3), Merchant.new(@ob4)]
    assert_equal expected, @rep.all
  end

  def test_update
    create_merchants
    
    assert_equal "bill", @rep.find_by_id(5).name

    @rep.update(5, name: 'Alf')

    assert_equal 'Alf', @rep.find_by_id(5).name
  end
end
