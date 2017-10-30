require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/sales_engine'


class SalesEngineTest < MiniTest::Test

  def test_setup

  end

  def test_it_exists
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end


end
