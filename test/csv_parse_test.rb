require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
# require_relative '../black_thursday/lib/csv_parse'
require './lib/csv_parse'


class CSVParseTest < Minitest::Test

  def setup
    # these tests might break with specharness / require relative
    path = './data/merchants.csv'
    @file = CSVParse.new(path)
    @csv = @file.parse
    @headers = @csv.shift
    # parsed is mutated
  end


  def test_it_exists
    assert_instance_of CSVParse, @file
  end

  def test_it_can_get_path
    path = './data/merchants.csv'
    assert_equal path, @file.path
  end

  def test_it_can_create_the_repository
    rows = @csv.first(2)
    first = {
      :name=>"Shopin1901",
      :created_at=>"2010-12-10",
      :updated_at=>"2011-12-04"
    }
    second = {
      :name=>"Candisart",
      :created_at=>"2009-05-30",
      :updated_at=>"2010-08-29"
    }
    expected = {:"12334105" => first, :"12334112" => second }
    assert_equal expected, @file.create_repo.first(2).to_h

  end

  def test_it_can_hash_all_rows
    # 12334105,Shopin1901,2010-12-10,2011-12-04
    # 12334112,Candisart,2009-05-30,2010-08-29
    rows = @csv.first(2)
    first = {
      :name=>"Shopin1901",
      :created_at=>"2010-12-10",
      :updated_at=>"2011-12-04"
    }
    second = {
      :name=>"Candisart",
      :created_at=>"2009-05-30",
      :updated_at=>"2010-08-29"
    }

    expected = {:"12334105" => first, :"12334112" => second }

    assert_equal expected, @file.hashed_rows(rows, @headers)

  end

  def test_it_can_fill_a_row
    expected = {
      :name=>"Shopin1901",
      :created_at=>"2010-12-10",
      :updated_at=>"2011-12-04"
    }
    temp = @file.template_hash(@headers)
    row = @csv[0]
    assert_equal expected, @file.fill_row(row, temp)
  end

  def test_it_create_template_hash
    hash = @file.template_hash(["id", "name", "created_at", "updated_at"])
    expected = {:name=>"", :created_at=>"", :updated_at=>""}
    assert_equal expected, hash
  end







end
