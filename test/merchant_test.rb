require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_initialize_takes_a_hash_of_fields
    assert_instance_of Merchant, turing_school
  end

  def test_it_has_an_id
    assert_equal 5, turing_school.id
  end

  def test_it_has_a_name
    assert_equal "Turing School", turing_school.name
  end

  def test_items_returns_an_array_of_items
    skip
    items = turing_school.items
    assert_instance_of Array, items
    refute items.empty?
    assert items.all? { |item| item.is_a? Item }
  end

  def test_items_returns_items_with_own_id_as_merchant_id
    skip
    assert turing_school.items.all? { item.merchant_id == turing_school.id }
  end

  def turing_school
    Merchant.new("this is supposed to be a repo hooked up to a sales engine", {
      id: 5,
      name: "Turing School"
    })
  end

end
