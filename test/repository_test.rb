require './test/test_helper.rb'
require './lib/repository'

class RepositoryTest < Minitest::Test
  def setup
    @rep = MerchantRepository.new

    @ob1 = {name: "bob", id: 4}
    @ob2 = {name: "deb", id: 3}
    @ob3 = {name: "john", id: 2}
    @ob4 = {name: "john",  id: 1}
    @ob5 = {name: "bill",id: 5}
  end

  def test_it_exists
    assert Repository === @rep
  end

  def test_all_returns_an_empty_array_by_default
    assert_equal [], @rep.all
  end

  def test_find_by_id_returns_nil_if_no_items
    assert_nil @rep.find_by_id(1)
  end

  def test_find_by_id_returns_found_instance
    @rep.create(@ob2)
    @rep.create(@ob3)
    @rep.create(@ob4)
    @rep.create(@ob5)
    assert_equal @obc5, @rep.find_by_id(5)
  end

  def test_find_by_name_returns_nil_if_no_items
    assert_nil @rep.find_by_name("Name of something")
  end

  def test_find_by_id_returns_instance_with_name
    @rep.create(@ob1)
    @rep.create(@ob2)
    @rep.create(@ob3)
    @rep.create(@ob4)

    assert_equal @obc3, @rep.find_by_name("john")
  end

  def test_find_all_by_name_returns_an_empty_array_if_none_found
    assert_equal [], @rep.find_all_by_name("name")
  end

  def test_find_all_by_name_returns_matched_objects_by_name
    @rep.create(@ob1)
    @rep.create(@ob2)
    @rep.create(@ob3)
    @rep.create(@ob4)

    assert_equal [@obc3, @obc4], @rep.find_all_by_name("john")
  end

  def test_create_adds_instances_to_array
    @rep.create(@ob1)
    @rep.create(@ob2)
    @rep.create(@ob3)
    @rep.create(@ob4)
    @rep.create(@ob5)

    expected = [@obc1, @obc2, @obc3, @obc4, @obc5]

    assert_equal expected, @rep.all
  end

  def test_deleting_by_id_removes_instance
    @rep.create(@ob1)
    @rep.create(@ob2)
    @rep.create(@ob3)
    @rep.create(@ob4)
    @rep.create(@ob5)

    @rep.delete(5)

    expected = [@obc1, @obc2, @obc3, @obc4]

    assert_equal expected, @rep.all
  end

  def test_update
    @rep.create(@ob3)
    @rep.create(@ob4)
    @rep.create(@ob5)
    @rep.update(5, name: 'Alf')
    assert_equal 'Alf', @rep.find_by_id(5).name
  end
end
