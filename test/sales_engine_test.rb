require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new({:id => "263395721", :name => "Disney scrabble frames", :description => "frames", :unit_price => "1350", :merchant_id => "12334185", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2008-04-02 13:48:57 UTC"})

    assert SalesEngine, se.item
  end
end
