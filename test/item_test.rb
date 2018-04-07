require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require './lib/item.rb'
require './lib/file_loader.rb'
require 'pry'

class ItemTest < Minitest::Test
  attr_reader :i

  def setup
    @i = Item.new({
      
      })

    263395721,Disney scrabble frames,"Disney glitter frames

    Any colour glitter available and can do any characters you require

    Different colour scrabble tiles

    Blue
    Black
    Pink
    Wooden",1350,12334185,2016-01-11 11:51:37 UTC,2008-04-02 13:48:57 UTC

  end

  def test_item_exists
    assert_instance_of Item, @i
  end
end
