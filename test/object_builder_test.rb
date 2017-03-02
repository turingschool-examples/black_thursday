require './test/test_helper'

class ObjectBuilderTest < Minitest::Test
  attr_reader :ob, :data_location, :obj_type_and_location

  def setup
    @ob = ObjectBuilder.new
    @data_location = './test/fixtures/single_item.csv'
    @obj_type_and_location = {items: './test/fixtures/single_item.csv', merchants: './test/fixtures/merchants_test_data.csv'}
  end

  def test_objecty_builder_exists
    assert_kind_of ObjectBuilder, ob
  end

  def test_get_lines
    assert_kind_of CSV, ob.get_lines(data_location)
  end

  def test_build_object
    arry_objects = ob.build_object(data_location, Item)
    assert_kind_of Array, arry_objects

    assert_kind_of Item, arry_objects[0]

    assert_equal 263500440, arry_objects[0].id
  end

  def test_read_lines
    object_collection = ob.read_csv(obj_type_and_location)
    assert_kind_of Hash, object_collection
    assert_equal [:merchant, :item], object_collection.keys
  end

  def test_assign_parents
    se = SalesEngine.new
    rb = RepoBuilder.new(se)
    ob =ObjectBuilder.new

    arry_objects = ob.read_csv(obj_type_and_location)
    assert_equal [:merchant, :item], arry_objects.keys

    repos = rb.build_repos(arry_objects)
    assert_equal 2, repos.length

    ob.assign_parents(repos)
    assert_kind_of MerchantRepository, repos[0].merchants[0].repository
    assert_kind_of ItemRepository, repos[1].items[0].repository
  end
end
