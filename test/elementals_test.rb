require 'time'
require_relative 'test_helper'
require_relative '../lib/elementals/elementals'

class ElementalsTest < Minitest::Test
  include Elementals

  def setup
    @time_now = Time.new
  end

  def test_format_time_returns_time_object
    # I need to look into how to better test this
    # assert_equal @time_now, format_time(Time.now)
    assert_equal Time.parse('2009-12-09 12:08:04 UTC'), format_time('2009-12-09 12:08:04 UTC')
  end
end
