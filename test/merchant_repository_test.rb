# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require_relative '../lib/merchant.rb'
require_relative '../lib/sales_engine.rb'

# Tests merchant repository method functionality
class MerchantRepositoryTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({:customers => './fixtures/customers_test.csv',
                               :merchants => './fixtures/merchants_test.csv',
                               :invoices => './fixtures/invoices_test.csv',
                               :items => './fixtures/items_test.csv'
      })
    @m = se.merchants
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @m
  end

  def test_it_can_find_by_id
    expected = 'Shopin1901'
    actual = @m.find_by_id(12334105).name

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_name
    expected = 12334112
    actual = @m.find_by_name('CANDISART').id

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_merchant_id
    expected = 'LolaMarleys'
    actual = @m.find_all_by_merchant_id(12334115).first.name

    assert_equal expected, actual
  end

  def test_it_can_delete_a_merchant
    @m.delete(12334105)
    actual = @m.find_by_id(12334105)

    assert_nil actual
  end

  def test_it_can_update_a_merchant
    expected = 'New Name'
    @m.update(12334123, name: 'New Name')
    actual = @m.find_by_id(12334123).name

    assert_equal expected, actual
  end

  def test_it_can_find_items_by_merchant_id
    expected = 'badass batman themed watch'
    actual = @m.find_items_by_merchant_id(92929).first.description

    assert_equal expected, actual
  end

  def test_it_can_find_invoices_by_merchant_id
    expected = :shipped
    actual = @m.find_invoices_by_merchant_id(12337139).first.status

    assert_equal expected, actual
  end

  def test_it_can_find_customers_by_merchant_id
    expected = 'Joey'
    actual = @m.find_customers_by_merchant_id(12335938).first.first_name

    assert_equal expected, actual
  end
end
