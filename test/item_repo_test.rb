require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repo'

class ItemRepoTest < Minitest::Test
    attr_reader :data,
                :parent,
                :item

end