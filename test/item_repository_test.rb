require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require "minitest/autorun"
require "minitest/pride"
require "./lib/item_repository"
require "pry"

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    item = ItemRepository.new

    assert_instance_of ItemRepository, item
  end

end
