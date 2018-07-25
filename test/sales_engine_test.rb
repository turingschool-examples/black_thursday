# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/emoji'
require './lib/sales_engine'

# Sales engine test
class SalesEngineTest < Minitest::Test
  def setup
    merchant1 = { id: 1, name: 'Bonos', created_at: '2010-12-22', updated_at: '2010-12-24' }
    merchant2 = { id: 2, name: 'General Store', created_at: '2016-04-19', updated_at: '2016-05-02' }
    merchant3 = { id: 5, name: 'Rufus Bazaar', created_at: '2017-02-02', updated_at: '2017-02-06' }
    merchants = [merchant1, merchant2, merchant3]

    item1 = { id: 1, name: 'Pencil', description: 'Use me to write things', unit_price: '1000', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 1 }
    item2 = { id: 1, name: 'Pen', description: 'Use me to write permanently', unit_price: '1200', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 1 }
    item3 = { id: 1, name: 'Paper', description: 'Use me to write things on', unit_price: '500', created_at: '2010-12-22', updated_at: '2011-05-04', merchant_id: 1 }
    items = [item1, item2, item3]

    data = { merchants: merchants, items: items }
    @se = SalesEngine.new(data)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_loads_repos
    refute_empty @se.merchants.all
    refute_empty @se.items.all
  end

  def test_it_can_use_sub_methods
    assert_instance_of Item, @se.items.find_by_id(1)
  end

  def test_it_can_run_analyst
    assert_instance_of SalesAnalyst, @se.analyst
  end
end
