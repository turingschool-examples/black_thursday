require_relative 'test_helper'
require_relative '../lib/fileio'

# Test for file io class
class FileIOTest < Minitest::Test
  def test_it_exists
    fileio = FileIO.new
    assert_instance_of FileIO, fileio
  end

  def test_it_gives_array
    assert_instance_of Array, FileIO.load('./test/fixtures/test_merchants0.csv')
  end

  def test_it_returns_correct_info
    expected = [%w[id name created_at updated_at],
                %w[12334105 Shopin1901 2010-12-10 2011-12-04],
                %w[12334112 Candisart 2009-05-30 2010-08-29],
                %w[12334113 MiniatureBikez 2010-03-30 2013-01-21],
                %w[12334115 LolaMarleys 2008-06-09 2015-04-16],
                %w[12334123 Keckenbauer 2010-07-15 2012-07-25],
                %w[12334132 perlesemoi 2009-03-21 2014-05-19],
                %w[12334135 GoldenRayPress 2011-12-13 2012-04-16]]
    assert_equal expected, FileIO.load('./test/fixtures/test_merchants.csv')
  end
end
