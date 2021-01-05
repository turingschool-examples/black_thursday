require 'time'
require 'csv'
require 'pry'
require 'BigDecimal'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))

    assert_instance_of ItemRepository, test
  end

  def test_it_can_give_all_items
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))
    sample = test.items

    assert_equal 1367, test.all.length
    assert_equal sample, test.all
  end

  def test_it_can_find_by_id
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))
    sample = test.items.first

    assert_nil test.find_by_id(11111111)
    assert_equal sample, test.find_by_id(263395237)

  end

  def test_it_can_find_by_name
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))
    sample = test.items.first

    assert_nil test.find_by_name("Hello World")
    assert_equal sample, test.find_by_name("510+ RealPush Icon Set")

  end

  def test_it_can_find_all_with_description
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))
    sample = test.items.first

    assert_equal [], test.find_all_with_description("fboagbrprgruoan")
    assert_equal [sample], test.find_all_with_description("icon on the planet earth")
  end

  def test_it_can_find_all_by_price
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))

    assert_equal [], test.find_all_by_price(1000000000)
    assert_equal 1, test.find_all_by_price(690).count
  end

  def test_it_can_find_all_by_price_in_range
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))

    assert_equal [], test.find_all_by_price_in_range(1000000..1000001)
    assert_equal 1, test.find_all_by_price_in_range(689..691).count
  end

  def test_it_can_find_all_by_merchant_id
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))
    sample = test.items.first

    assert_equal [], test.find_all_by_merchant_id(7)
    assert_equal [sample], test.find_all_by_merchant_id(12334141)
  end

  def test_max_item_id
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))

    assert_equal "263567474", test.max_item_id[:id]
  end

  def test_it_can_create
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))


  end

  def test_it_can_update
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))
    hash1 = {:name => "Computer",
            :description => "This is a computer.",
            :unit_price => 125}

    test.update(263395237, hash1)
    sample = test.items.first


    assert_equal "Computer", sample[:name]
    assert_equal "This is a computer.", sample[:description]
    assert_equal 125, sample[:unit_price]
  end

  def test_it_can_delete
    test = ItemRepository.new(CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol))
    sample = test.items.first

    test.delete(263395237)

    assert_equal false, test.items.first == sample
  end
end
