require_relative 'test_helper.rb'
require_relative '../lib/item'
class ItemTest < Minitest::Test
  def sample_path
    {:name=>"Glitter scrabble frames",
     :description=>"Glitter scrabble frames\n\nAny colour glitter\nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden",
     :unit_price=>"1300",
     :merchant_id=>"12334185",
     :created_at=>"2016-01-11 11:51:37 UTC",
     :updated_at=>"1993-09-29 11:56:40 UTC"}
  end

  def test_it_exists
    i = Item.new(sample_path, nil)

    assert_instance_of Item, i
  end

  def test_has_name
    i = Item.new(sample_path, nil)

    assert_equal "Glitter scrabble frames", i.name
  end

  def test_has_description
    i = Item.new(sample_path, nil)

    assert_equal "Glitter scrabble frames", i.name
  end

  def test_has_unit_price
    i = Item.new(sample_path, nil)

    assert_equal 13.0, i.unit_price.to_f
  end

  def test_has_merchant_id
    i = Item.new(sample_path, nil)

    assert_equal 12334185, i.merchant_id
  end

  def test_convert_created_at_time
    i = Item.new(sample_path, nil)
    time = Time.utc(2016,01,11,11,51,37)

    assert_equal time, i.created_at
  end

  def test_convert_updated_at_time
    i = Item.new(sample_path, nil)

    assert_equal "1993-09-29 11:56:40 UTC", i.updated_at.to_s
  end

end
