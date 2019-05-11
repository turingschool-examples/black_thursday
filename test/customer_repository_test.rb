# frozen_string_literal: true

require './test/test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'
require 'pry'

# This is a CustomerRepositoryTest Class
class CustomerRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      items:         './test/fixtures/items_truncated.csv',
      merchants:     './test/fixtures/merchants_truncated.csv',
      invoices:      './test/fixtures/invoices_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_truncated.csv',
      transactions:  './test/fixtures/transactions_truncated.csv',
      customers:     './test/fixtures/customers_truncated.csv'
    })

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
    actual = @cr.find_all_by_first_name('jo')

    assert_instance_of Customer, actual.first
    assert_instance_of Array, actual
    assert_equal 3, actual.count

    actual = @cr.find_all_by_first_name('343e4343')

    assert_equal [], actual
  end

  def test_find_all_by_last_name
    actual = @cr.find_all_by_last_name('ON')

    assert_instance_of Customer, actual.first
    assert_instance_of Array, actual
    assert_equal 3, actual.count

    actual = @cr.find_all_by_first_name('343e4343')

    assert_equal [], actual
  end

  def test_create
    assert_equal 10, @cr.all.count
    assert_equal 10, @cr.all.last.id

    attributes = ({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
                   })

    @cr.create(attributes)

    actual = @cr.all.last

    assert_equal 11, actual.id
    assert_equal 'Joan', actual.first_name
    assert_equal 'Clarke', actual.last_name
    assert_equal 11, @cr.all.count
  end

  def test_update
    actual = @cr.find_by_id(9)
    initial_updated_at = actual.updated_at

    assert_equal 'Dejon', actual.first_name
    assert_equal 'Fadel', actual.last_name

    attributes = ({ first_name: "Joan",
                    last_name:  "Clarke" })

    @cr.update(9, attributes)

    assert_equal 'Joan', actual.first_name
    assert_equal 'Clarke', actual.last_name
    refute_equal initial_updated_at, actual.updated_at
  end

  def test_delete
    assert_equal 10, @cr.customers.count

    @cr.delete(1)

    assert_nil @cr.find_by_id(1)
    assert_equal 9, @cr.customers.count
  end
end
