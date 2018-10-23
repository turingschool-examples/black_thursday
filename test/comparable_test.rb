require './test/test_helper'
require './lib/comparable'

class GenericObject
  include Comparable
  attr_reader :name, :id
  def initialize(name, id)
    @name = name
    @id = id
  end
end

class OtherGenericObject
  include Comparable
  attr_reader :name, :id
  def initialize(name, id)
    @name = name
    @id = id
  end
end

class ComparableTest < Minitest::Test

  def setup
    @ob1 = GenericObject.new("a", 3)
    @ob2 = GenericObject.new("a", 3)
    @ob3 = GenericObject.new("b", 3)
    @ob4 = OtherGenericObject.new("a", 3)
  end

  def test_it_finds_similar_objects_to_be_the_same
    assert_equal @ob1, @ob2
  end

  def test_it_finds_different_objects_to_be_different
    refute_equal @ob1, @ob3
  end

  def test_it_finds_similar_objects_of_the_different_classes_to_be_different
    refute_equal @ob1, @ob4
  end

end
