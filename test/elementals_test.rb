require 'time'
require_relative 'test_helper'
require_relative '../lib/elementals/elementals'

# Elementals test
class ElementalsTest < Minitest::Test
  include Elementals

  def setup
    @time_now = Time.new
  end

  def test_format_time_returns_time_object
    actual = format_time('2009-12-09 12:08:04 UTC')
    assert_equal Time.parse('2009-12-09 12:08:04 UTC'), actual
  end
end
