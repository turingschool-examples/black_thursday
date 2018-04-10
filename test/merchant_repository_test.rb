# frozen_string_literal: true

require './test/test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'
require 'pry'

# This is a MerchantRepositoryTest Class
class MerchantRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv( { :items     => './test/fixtures/items_truncated.csv',
                                  :merchants => './test/fixtures/merchants_truncated.csv',
                                } )
    @mr = @se.merchants
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_returns_all_instances
    refute @mr.merchants.empty?, @mr.merchants
    assert_equal 6, @mr.all.count
    assert_equal 'HeadyMamaCreations', @mr.all[0].name
  end

  def test_find_by_id
    assert_nil @mr.find_by_id(7834)
    assert_instance_of Merchant, @mr.find_by_id(1)
  end

  def test_find_by_name
    assert_nil @mr.find_by_name('Buffalo Bill')

    assert_equal 'HeadyMamaCreations', @mr.find_by_name('HeadyMamaCreations').name
    assert_equal 'HeadyMamaCreations', @mr.find_by_name('headyMAMACreations').name
  end

  def test_find_all_by_name
    skip
    assert_equal [], @mr.find_all_by_name('Buffalo Bill')
    assert_equal ['HeadyMamaCreations'], @mr.find_all_by_name('headyMamacreations')
    assert_equal ['CJsDecor', 'CJsDecorTEST'], @mr.find_all_by_name('cj')
  end

  def test_find_highest_id
    assert_equal 6, @mr.find_highest_id
  end

  def test_create_new_id
    assert_equal 7, @mr.create_new_id
  end

  def test_create
    @mr.create({:id => 600, :name => 'Turing School'})
    assert_equal 7, @mr.all.last.id
    assert_equal 'Turing School', @mr.all[6].name
  end

  def test_update
    found = @mr.find_by_id(1)
    assert_equal 'HeadyMamaCreations', found.name
    assert_equal 1, found.id
    @mr.update(1, {:name => 'FuzzysBuzzMachine'})
    assert_equal 'FuzzysBuzzMachine', found.name
    assert_equal 1, found.id
    assert_nil @mr.update(64, {:name => "felbert"})
  end

  def test_delete
    @mr.create({:id => 5, :name => 'Turing School'})

    assert_equal 7, @mr.all.last.id
    @mr.delete(7)
    refute_equal 7, @mr.all.last.id
  end
end
