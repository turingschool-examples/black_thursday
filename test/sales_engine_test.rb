# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require './lib/sales_engine.rb'

class SalesEngineTest < MiniTest::Test

  def setup
    @s = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @s
  end

  def test_it_can_load_items
    expected = ''
    actual = @s.load_items

    assert_equal expected, actual
  end

end
