# Frozen_string_literal: true

require './test/test_helper'
require './lib/sales_engine'
# Merchant Repository
class MerchantRepositoryTest < Minitest::Test
  attr_reader :se
  def setup
    @se = SalesEngine.from_csv(
  :items     => './test/fixtures/item_fixture.csv',
  :merchants => './test/fixtures/merchant_fixture.csv'
  )
  end

  def test_it_exists
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_returns_all_merchants
    assert_equal 5, se.merchants.all.count
    assert_instance_of Array, se.merchants.all
    assert_instance_of Merchant, se.merchants.all[0]
  end

  def test_it_has_id
    assert_instance_of Merchant, se.merchants.find_by_id(12_334_105)
    assert_equal 'Shopin1901', se.merchants.find_by_id(12_334_105).name
    assert_nil se.merchants.find_by_id(20)
  end

  def test_find_by_name
    assert_equal 'Shopin1901', se.merchants.find_by_name('Shopin1901').name
    assert_nil se.merchants.find_by_name('morty')
  end

  def test_find_all_by_name
    assert_instance_of Array, se.merchants.find_all_by_name('Candisart')
    assert_instance_of Merchant, se.merchants.find_all_by_name('Can')[0]
    assert_equal 2, se.merchants.find_all_by_name('Can').count
    assert_equal 12_334_112, se.merchants.find_all_by_name('Candisart')[0].id
  end

  def test_create_new_merchants_with_attributes
    attributes = {
        name: "Turing School of Software and Design"
      }

    assert_equal 12_334_124, se.merchants.create(attributes).id
  end

  # def test_it_can_update_an_merchant
  #   # this needs refactoring
  #   attributes = {
  #       name: 'Turing School of Software and Design'
  #     }
  #   id = '263399188'
  #
  #   assert_equal 'Turing School of Software and Design', se.merchants.update(id, attributes[:name])
  # end

  # def test_it_can_delete_an_merchant
  #   assert_instance_of Merchant, se.merchants.delete('12334112')
  #   assert_equal 4, se.merchants.all.count
  # end
end
