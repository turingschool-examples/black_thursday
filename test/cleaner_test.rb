require 'minitest/autorun'
require 'minitest/pride'
require './lib/cleaner'

class CleanerTest < MiniTest::Test

  def setup
    @merchant_csv = "./data/merchants.csv"
    @items_csv = "./data/items.csv"
    @cleaner = Cleaner.new(@merchant_csv, @items_csv)
    @merchant_data = CSV.open(@merchant_csv, headers: true, header_converters: :symbol)
    @items_data = CSV.open(@items_csv, headers: true, header_converters: :symbol)
    @merchant_rows = @merchant_data.map { |row| row }
    @item_rows = @items_data.map { |row| row }
  end

  def test_it_exists_with_attributes
    assert_instance_of Cleaner, @cleaner

    assert_equal @merchant_csv, @cleaner.merchant_csv
    assert_equal @items_csv, @cleaner.items_csv
  end

  def test_it_can_open_data
    assert_equal @merchant_data.class, @cleaner.open_csv(@merchant_csv).class
  end

  def test_it_id_is_an_integer
    expected = @merchant_rows[0][:id].to_i

    assert_equal expected, @cleaner.clean_id("12334105")
  end

  def test_names_are_readable
    expected = @merchant_rows[5][:name].capitalize

    assert_equal expected, @cleaner.clean_name("perlesemoi")
  end

  def test_dates_are_time_class
    expected = Time.new(2010, 12, 10)

    assert_equal expected, @cleaner.clean_date("2010-12-10")
  end
end
