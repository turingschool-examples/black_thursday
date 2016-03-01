require_relative '../lib/travis'
require 'minitest/autorun'

class TravisTest < Minitest::Test

  def test_travis_is_a_class
    travis = Travis.new(4)

    assert_equal Travis, travis.class
  end

  def test_travis_has_a_number
    travis = Travis.new(3)

    assert_equal 3, travis.number
  end

end
