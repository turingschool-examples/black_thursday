# frozen_string_literal:true

require_relative 'test_helper'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv( { :items     => './test/fixtures/items_truncated.csv',
                                  :merchants => './test/fixtures/merchants_truncated.csv',
                                } )
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_loads_csv_data
    assert_instance_of ItemRepository, @se.item_repository
    # assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_can_access_items
    assert_instance_of Item, @se.item_repository.find_by_name('Disney scrabble frames')
    assert_instance_of Merchant, @se.merchant_repository.find_by_name('HeadyMamaCreations')
  end
end
