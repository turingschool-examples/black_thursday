require 'minitest/autorun'
require 'minitest/pride'
require './lib/cleaner'
require 'csv'

class CleanerTest < MiniTest::Test

  def setup
    @file = "/Users/alexamsmyth/turing/1mod/projects/black_thursday/data/merchants.csv"
    @data = CSV.open(@file, headers: true, header_converters: :symbol)
    @rows = @data.map do |row|
      row
    end
  end

  def test_it_exists
    cleaner = Cleaner.new

    assert_instance_of Cleaner, cleaner
  end

  def test_it_has_readable_attributes
    cleaner = Cleaner.new

    assert_equal @data.class, cleaner.contents.class
  end

  def test_it_id_is_an_integer
    cleaner = Cleaner.new
    expect = @rows[0][:id].to_i

    assert_equal expect, cleaner.clean_id("12334105")
  end

end
