require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository.rb'
require './test/test_helper.rb'
require 'csv'
require 'pry'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_csv = CSV.open './test/fixtures/items.csv', headers: true, header_converters: :symbol
    @parent = ""
  end
  
  def test_it_exists
    assert_instance_of ItemRepository, ItemRepository.new(@item_csv, 2)
  end

  def test_all_array
    repo = ItemRepository.new(@item_csv, @parent)
    # repo.make_repository
    assert_equal 3, repo.all.length
  end

  def test_finds_by_id
    repo = ItemRepository.new(@item_csv, @parent)
    assert_equal Item, repo.find_by_id(263396013).class
    assert_nil repo.find_by_id(3)
  end

  def test_finds_by_name
    repo = ItemRepository.new(@item_csv, @parent)
    assert_equal Item, repo.find_by_name('Glitter scrabble frames').class
    assert_equal Item, repo.find_by_name('Glitter scrabble frames'.upcase).class
    assert_nil repo.find_by_name("")
  end

  def test_it_finds_by_description
    repo = ItemRepository.new(@item_csv, @parent)
    assert_equal Array, repo.find_all_with_description('Glitter').class
    assert_equal 2, repo.find_all_with_description('Glitter').length
    assert_equal Array, repo.find_all_with_description('GLiTTer').class
    assert_equal 2, repo.find_all_with_description('GLITTER').length
    assert_equal [], repo.find_all_with_description("not in the description")
  end

  def test_it_finds_by_price
    repo = ItemRepository.new(@item_csv, @parent)

  end

end