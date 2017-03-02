require './test/test_helper'

class RepoBuilderTest < Minitest::Test
  attr_reader :rb, :obj_type_and_location, :ob, :arry_objects
  def setup
    se = SalesEngine.new
    @obj_type_and_location = {items: './test/fixtures/single_item.csv', merchants: './test/fixtures/merchants_test_data.csv'}
    @rb = RepoBuilder.new(se)
    @ob = ObjectBuilder.new
    @arry_objects = ob.read_csv(obj_type_and_location)

  end

  def test_repo_builder_exists
    assert_kind_of RepoBuilder, rb
  end

  def test_build_repos
    assert_kind_of Array, rb.build_repos(arry_objects)
  end
end
