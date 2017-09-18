require './test/test_helper'
require './lib/merchant'
require './lib/item'
require './lib/invoice'

class MerchantTest < Minitest::Test

  def new_merchant(data)
    Fixture.new_record(:merchants, data)
  end

  def merchant_12334105
    f = Fixture.find_record(:merchants, 12334105)
  end

  def merchant_12334105_expected
    {
      id: 12334105,
      name: 'Shopin1901',
      created_at: Time.parse('2010-12-10'),
      updated_at: Time.parse('2011-12-04')
    }
  end



  def test_initialize_takes_a_hash_of_strings
    assert_instance_of Merchant, new_merchant({
      id: '12334105',
      name: 'Shopin1901',
      created_at: '2010-12-10',
      updated_at: '2011-12-04'
    })
  end

  def test_it_has_an_Integer_id
    assert_equal 12334105, merchant_12334105.id
  end

  def test_it_has_a_String_name
    assert_equal merchant_12334105_expected[:name], merchant_12334105.name
  end

  def test_it_has_a_Time_created_at
    assert_equal merchant_12334105_expected[:created_at], merchant_12334105.created_at
  end

  def test_it_has_a_Time_updated_at
    assert_equal merchant_12334105_expected[:updated_at], merchant_12334105.updated_at
  end

  def test_id_defaults_to_Integer
    merchant = new_merchant({
      name: 'Shopin1901',
      created_at: '2010-12-10',
      updated_at: '2011-12-04'
    })
    assert_instance_of Integer, merchant.id
  end

  def test_created_at_defaults_to_Time
    merchant = new_merchant({
      id: '12334105',
      name: 'Shopin1901',
      updated_at: '2011-12-04'
    })
    assert_instance_of Time, merchant.created_at
  end

  def test_updated_at_defaults_to_Time
    merchant = new_merchant({
      id: '12334105',
      name: 'Shopin1901',
      created_at: '2010-12-10'
    })
    assert_instance_of Time, merchant.created_at
  end

  def test_items_returns_an_array_of_items
    items = merchant_12334105.items
    assert_instance_of Array, items
    assert items.all? { |item| item.is_a? Item }
  end

  def test_items_returns_only_items_with_own_id_as_merchant_id
    assert merchant_12334105.items.all? { |item| item.merchant_id == 12334105 }
  end

  def test_items_returns_an_array_of_item
    items = merchant_12334105.items
    assert_instance_of Array, items
    refute_empty items
    assert items.all? { |item| item.is_a? Item }
  end

  def test_items_returns_only_items_with_own_id_as_merchant_id
    assert merchant_12334105.items.all? { |item| item.merchant_id == 12334105 }
  end

  def test_items_returns_empty_array_if_no_items_match
    bad_merchant = new_merchant({
      id: -1,
      name: 'Shopin1901',
      created_at: '2010-12-10',
      updated_at: '2011-12-04'
    })
    assert_empty bad_merchant.items
  end

  def test_invoices_returns_an_array_of_invoice
    invoices = merchant_12334105.invoices
    assert_instance_of Array, invoices
    refute_empty invoices
    assert invoices.all? { |invoice| invoice.is_a? Invoice }
  end

  def test_invoices_returns_only_invoices_with_own_id_as_merchant_id
    assert merchant_12334105.invoices.all? { |invoice| invoice.merchant_id == 12334105 }
  end

  def test_invoices_returns_empty_array_if_no_invoices_match
    lazy_merchant = new_merchant({
      id: -1,
      name: 'whatever',
      created_at: '2010-12-10',
      updated_at: '2011-12-04'
    })
    assert_empty lazy_merchant.invoices
  end

  def test_customers_returns_an_array_of_customers
    customers = merchant_12334105.customers
    assert_instance_of Array, customers
    refute customers.empty?
    assert customers.all? { |customer| customer.is_a? Customer }
  end

  def test_customers_are_always_linked_through_invoices
    merchant = merchant_12334105
    expected_ids = merchant.invoices.map(&:customer_id).sort
    actual_ids = merchant.customers.map(&:id).uniq.sort
    assert expected_ids == actual_ids
  end

  def test_customers_contains_no_duplicates
    customers = merchant_12334105.customers
    assert_equal customers.uniq, customers
  end

end
