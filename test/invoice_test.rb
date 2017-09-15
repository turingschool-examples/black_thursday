require './test/test_helper'

require './lib/invoice'


class InvoiceTest < Minitest::Test

  def setup
    @se = Fixture.sales_engine
  end

  def invoice(id = 1)
    @se.invoices.find_by_id(id)
  end

  def test_initialize_takes_a_hash_of_strings
    assert_instance_of Item, item
  end

  def test_it_has_an_Integer_id
    assert_same 1, item.id
  end

  def test_it_has_an_Integer_merchant_id
    assert_same 2, item.merchant_id
  end

  def test_it_has_a_String_name
    assert_equal "Pencil" , item.name
  end

  def test_it_has_a_String_description
    assert_equal "You can use it to write things" , item.description
  end

  def test_it_has_a_BigDecimal_unit_price
    assert_instance_of BigDecimal, item.unit_price
    assert_equal BigDecimal.new("10.99"), item.unit_price
  end

  def test_it_has_a_Time_created_at
    assert_equal Time.new(given[:created_at]), item.created_at
  end

  def test_it_has_a_Time_updated_at
    assert_equal Time.new(given[:updated_at]), item.updated_at
  end

  def test_merchant_returns_a_single_merchant
    assert_instance_of Merchant, item.merchant
  end

  def test_merchant_has_id_same_as_merchant_id
    assert_equal item.merchant_id, item.merchant.id
  end

end



id - returns the integer id
customer_id - returns the customer id
merchant_id - returns the merchant id
status - returns the status
created_at - returns a Time instance for the date the item was first created
updated_at - returns a Time instance for the date the item was last modified
