require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require 'csv'
class MerchantRepositoryTest < Minitest::Test

  def setup
    @engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      customers: './data/customers.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    })
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @engine.merchants
  end

  def test_all_returns_an_array_of_all_merchant_instances
    expected = @engine.merchants.all
    assert_equal 475, expected.count
  end

  def test_find_by_id_find_a_merchant_by_id
    id = 12335971
    expected = @engine.merchants.find_by_id(id)
    assert_equal 12335971, expected.id
    assert_equal "ivegreenleaves", expected.name
  end

  def test_find_by_id_returns_nil_if_the_merchant_does_not_exist
    id = 101
    expected = @engine.merchants.find_by_id(id)
    assert_nil expected
  end

  def test_find_by_name_finds_the_first_matching_merchant_by_name
    name = 'leaburrot'
    expected = @engine.merchants.find_by_name(name)
    assert_equal 12334411, expected.id
    assert_equal name, expected.name
  end

  def test_find_by_name_is_a_case_insensitive_search
    name = "LEABURROT"
    expected = @engine.merchants.find_by_name(name)
    assert_equal 12334411, expected.id
  end

  def test_find_by_name_returns_nil_if_the_merchant_does_not_exist
    name = "Turing School of Software and Design"
    expected = @engine.merchants.find_by_name(name)
    assert_nil expected
  end

  def test_find_all_by_name_finds_all_merchants_matching_given_name_fragment
    fragment = "style"
    expected = @engine.merchants.find_all_by_name(fragment)
    assert_equal 3, expected.length
    assert expected.map(&:name).include?("justMstyle")
    assert expected.map(&:id).include?(12337211)
  end

  def test_find_all_by_name_returns_an_empty_array_if_there_are_no_matches
    name = "Turing School of Software and Design"
    expected = @engine.merchants.find_all_by_name(name)
    assert_equal [], expected
  end

  def test_create_creates_a_new_merchant_instance
    attributes = { name: 'Turing School of Software and Design'}
    @engine.merchants.create(attributes)
    expected = @engine.merchants.find_by_id(12337412)
    assert_equal 'Turing School of Software and Design', expected.name
  end

  def test_update_updates_a_merchant
    attributes = { name: 'Turing School of Software and Design'}
    @engine.merchants.create(attributes)
    updated_attributes = {name: 'TSSD'}
    @engine.merchants.update(12337412, updated_attributes)
    expected = @engine.merchants.find_by_id(12337412)
    assert_equal 'TSSD', expected.name
    expected = @engine.merchants.find_by_name('Turing School of Software and Design')
    assert_nil expected
  end

  def test_update_cannot_update_id
    attributes = {id: 13000000}
    @engine.merchants.update(12337412, attributes)
    expected = @engine.merchants.find_by_id(13000000)
    assert_nil expected
  end

  def test_update_on_unknown_merchant_does_nothing
    expected = @engine.merchants.update(13000000, {})
    assert_nil expected
  end

  def test_delete_deletes_the_specified_merchant
    @engine.merchants.delete(12337412)
    expected = @engine.merchants.find_by_id(12337412)
    assert_nil expected
  end

  def test_delete_on_unknown_merchant_does_nothing
    expected = @engine.merchants.delete(12337412)
    assert_nil expected
  end

end
