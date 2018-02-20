# frozen_string_literal: true

require_relative 'test_helper'

require 'bigdecimal'
require_relative '../lib/item_repository.rb'

class ItemReposityTest < Minitest::Test
  def setup
    @ir = ItemRepository.new './data/items.csv'
  end

  def test_does_create_repository
    assert_instance_of ItemRepository, @ir
  end
end
