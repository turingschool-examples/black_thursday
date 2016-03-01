require_relative '../lib/travis'
require 'minitest/autorun'

class TravisTest < Minitest::Test

  def test_travis_is_a_class
    travis = Travis.new

    assert_equal Travis, travis.class
  end

end
