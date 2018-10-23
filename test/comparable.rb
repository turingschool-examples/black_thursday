require './test/test_helper'
require './lib/comparable'

class GenericObject
  include Comparable

  def initialize(name, id)
    @name = name
    @id = id
  end
end

class ComparableTest < Minitest::Test

  def setup
  end

  def test_it_finds_similar_objects_to_be_the_same
    assert_equal
  end

  def test_it_finds_differnt_objects_to_be_different
    assert_equal
  end

end
