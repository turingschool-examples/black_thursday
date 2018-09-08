require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
# require_relative '../black_thursday/lib/csv_parse'
require './lib/csv_parse'




class CSVParseTest < Minitest::Test

  def setup
    # these tests might break with specharness / require relative
    @path = './data/merchants.csv'
  end

  # These are no longer necessary for class methods (?)
  # ==============================================
  # def test_it_exists
  #   assert_instance_of CSVParse, @file
  # end

  # def test_it_can_get_path
  #   path = './data/merchants.csv'
  #   assert_equal path, @file.path
  # end
  # ==============================================

  def test_it_can_create_the_repository
    first = {:name=>"Shopin1901", :created_at=>"2010-12-10", :updated_at=>"2011-12-04"}
    second = {:name=>"Candisart", :created_at=>"2009-05-30", :updated_at=>"2010-08-29"}
    expected = {:"12334105" => first, :"12334112" => second }
    assert_equal expected, CSVParse.create_repo(@path).first(2).to_h
  end

  def test_it_can_hash_all_rows
    # 12334105,Shopin1901,2010-12-10,2011-12-04
    # 12334112,Candisart,2009-05-30,2010-08-29
    headers, *rows = CSVParse.parse(@path)
    first = {:name=>"Shopin1901", :created_at=>"2010-12-10", :updated_at=>"2011-12-04"}
    second = {:name=>"Candisart", :created_at=>"2009-05-30", :updated_at=>"2010-08-29"}
    expected = {:"12334105" => first, :"12334112" => second }
    assert_equal expected, CSVParse.hashed_rows(rows.first(2), headers)
  end

  def test_it_can_fill_a_row
    expected = {:name=>"Shopin1901", :created_at=>"2010-12-10", :updated_at=>"2011-12-04"}
    headers, *rows = CSVParse.parse(@path)
    temp = {:name=>"", :created_at=>"", :updated_at=>""}
    assert_equal expected, CSVParse.fill_row(rows[0], temp)
  end

  def test_it_create_template_hash
    headers = ["id", "name", "created_at", "updated_at"]
    hash = CSVParse.template_hash(headers)
    expected = {:name=>"", :created_at=>"", :updated_at=>""}
    assert_equal expected, hash
  end
end
