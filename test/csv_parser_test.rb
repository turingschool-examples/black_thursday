require './test/test_helper'

class CsvParserTest < Minitest::Test

  include CsvParser

  def test_opens_file
    file = open_file('./test/fixtures/merchants_three.csv')
    assert_equal CSV, file.class
  end

end
