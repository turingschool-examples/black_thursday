# frozen_string_literal: true

require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_repo = ItemRepository.new
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repo
  end
end
