require 'minitest/autorun'
require 'minitest/pride'
require './lib/cleaner'

class CleanerTest < MiniTest::Test

  def setup
    @cleaner = Cleaner.new
  end

  def test_it_exists

    assert_instance_of Cleaner, @cleaner
  end

  def test_it_id_is_an_integer
    expected = 12334105

    assert_equal expected, @cleaner.clean_id("12334105")
  end

  def test_names_are_readable
    expected = "perlesemoi"

    assert_equal expected, @cleaner.clean_name("perlesemoi")
  end

  def test_dates_are_time_class
    # 0123-45-67-9
    # 2016-01-11 09:34:06 UTC
    # 2016-01-11 11:51:37 UTC
    expected = Time.new(2010, 12, 10)
    expected2 = Time.new(2016, 01, 11, 11, 51, 37)


    assert_equal expected2, @cleaner.clean_date("2016-01-11 11:51:37 UTC")
    assert_equal expected, @cleaner.clean_date("2010-12-10")
  end

  def test_clean_time_hour_minute_second
    expected = Time.new(2010, 12, 10)
    expected2 = Time.new(2016, 01, 11, 11, 51, 37)

    assert_equal expected2, @cleaner.clean_date_time("2016-01-11 11:51:37 UTC")
    assert_equal expected, @cleaner.clean_date_only("2010-12-10")
    assert_equal 11, @cleaner.clean_date_hour("2016-01-11 11:51:37 UTC")
    assert_equal 51, @cleaner.clean_date_minute("2016-01-11 11:51:37 UTC")
    assert_equal 37, @cleaner.clean_date_second("2016-01-11 11:51:37 UTC")

  end
end
