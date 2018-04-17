# frozen_string_literal: true

require './test/test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'
require 'pry'

# This is a MerchantRepositoryTest Class
class MerchantRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      {
        items:         './test/fixtures/items_truncated.csv',
        merchants:     './test/fixtures/merchants_truncated.csv',
        invoices:      './test/fixtures/invoices_truncated.csv',
        invoice_items: './test/fixtures/invoice_items_truncated.csv',
        transactions:  './test/fixtures/transactions_truncated.csv',
        customers:     './test/fixtures/customers_truncated.csv'
      } )

    @cr = @se.customers
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cr
  end

  def test_returns_all_instances
    refute @cr.customers.empty?, @cr.customers
    assert_equal 10, @cr.all.count
    assert_equal 'Joey', @cr.all[0].first_name
  end

  def test_find_by_id
    assert_nil @cr.find_by_id(7834)
    assert_instance_of Customer, @cr.find_by_id(5)
  end

  def test_find_by_name
    assert_nil @cr.find_by_first_name('Buffalo Bill')

    assert_equal 'LovesVariety', @cr.find_by_name('lovesVARIety').name
    assert_equal 'LovesVariety', @cr.find_by_name('LovesVariety').name
  end

  def test_find_all_by_name
    skip

    assert_equal [], @cr.find_all_by_name('Buffalo Bill')
    assert_equal 'LovesVariety', @cr.find_all_by_name('lovesVARIety')[0].name
    assert_equal 2, @cr.find_all_by_name('cj').count
  end

  def test_create
    skip
    @cr.create({:id => 600, :name => 'Turing School'})
    assert_equal 7, @cr.all.last.id
    assert_equal 'Turing School', @cr.all.last.name
  end

  def test_update
    skip
    found = @cr.find_by_id(5)

    assert_equal 'CJsDecor', found.name
    assert_equal 5, found.id

    @cr.update(5, {:name => 'Awesomeness'})

    assert_equal 'Awesomeness', found.name
    assert_equal 5, found.id

    assert_nil @cr.update(64, {:name => "felbert"})
  end

  def test_delete
    skip
    assert_equal 6, @cr.customers.count

    @cr.delete(1)

    assert_nil @cr.find_by_id(1)
    assert_equal 5, @cr.customers.count
  end
end
