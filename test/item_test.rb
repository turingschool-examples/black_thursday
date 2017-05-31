require 'minitest/autorun'
require 'minitest/emoji'
require './lib/item'
require 'csv'
require 'bigdecimal'
class ItemTest < Minitest::Test
  def file_setup
    header = CSV.read("/Users/jimmytruong/turing/1module/projects/black_thursday/test/itemsample.csv")[0]
    content = CSV.read("/Users/jimmytruong/turing/1module/projects/black_thursday/test/itemsample.csv")[1 .. -1].flatten
    line = header.zip(content).flatten.compact
    item_info = Hash[*line]
  end

  def test_it_exists
    i = Item.new(file_setup)

    assert_instance_of Item, i
  end

  def test_has_ID
    i = Item.new(file_setup)

    assert_equal 263395721, i.id
  end

  def test_has_name
    i = Item.new(file_setup)

    assert_equal "Disney scrabble frames", i.name
  end

  def test_has_description
    i = Item.new(file_setup)

    assert_equal "Disney glitter frames", i.description
  end

  def test_has_unit_price
    i = Item.new(file_setup)
    price = BigDecimal.new("1350")

    assert_equal price, i.unit_price
  end

  def test_has_merchant_id
    i = Item.new(file_setup)

    assert_equal 12334185, i.merchant_id
  end

  def test_has_time_of_creation
    i = Item.new(file_setup)
    time = Time.utc(2016,01,11,11,51,37)
    assert_equal time, i.created_at
  end

  def test_has_time_that_it_was_last_updated
    i = Item.new(file_setup)
    time = Time.utc(2008,04,02,13,48,57)

    assert_equal time, i.updated_at
  end


end
