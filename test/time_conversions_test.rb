require './test/test_helper'
require './lib/time_conversions'

class TimeConversionTest < Minitest::Test
  include TimeConversions

  def test_it_converts_time
    time = Time.utc(2016, 01, 11, 11, 46, 07)
    time_string = "2016-01-11 11:46:07 UTC"
    assert_equal time, to_time(time_string)
  end

end
