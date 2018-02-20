# frozen_string_literal: true

require_relative 'test_helper'

require 'bigdecimal'
require_relative '../lib/item_repository.rb'

class ItemReposityTest < Minitest::Test
  def test_does_create_repository
    repository = ItemRepository.new
    assert_instance_of ItemRepository, repository
  end
end
