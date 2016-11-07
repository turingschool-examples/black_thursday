require_relative 'test_helper'

class MerchantTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./fixtures/items_small_list.csv",
    :merchants => "./fixtures/merchant_small_list.csv",
    :invoices  => "./fixtures/invoices_small_list.csv"
      })
    @merch = @se.merchants.all[0]
  end

  def test_it_exists
    assert @merch
  end

  def test_it_is_a_merchant
    assert_equal Merchant, @merch.class
  end

  def test_it_has_name_and_id
    assert_equal 12334105, @merch.id
    assert_equal "Shopin1901", @merch.name
  end
  
  def test_it_can_find_its_items_in_an_array
    assert_equal Array, @merch.items.class
  end

  def test_it_knows_when_it_was_created
    assert_equal "2010-12-10", @merch.created_at
  end

  def test_it_knows_when_it_was_updated
    assert_equal "2011-12-04", @merch.updated_at
  end

end