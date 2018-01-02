require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require "minitest/autorun"
require "minitest/pride"
require "./lib/item_respository"
require "pry"

class ItemRespositoryTest < Minitest::Test

  def test_it_exists
    item = ItemRespository.new

    assert_instance_of ItemRespository, item
  end

end
