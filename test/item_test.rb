require_relative 'test_helper'

class ItemTest < Minitest::Test
    
  def setup
    se = SalesEngine.from_csv({
    :items     => "./fixtures/items_small_list.csv",
    :merchants => "./fixtures/merchant_small_list.csv",
    :invoices  => "./fixtures/invoices_small_list.csv"
    })
    @ir = se.items
  end

  def test_it_knows_name
    assert_equal "510+ RealPush Icon Set", @ir.all[0].name
    assert_equal "Cache cache à la plage", @ir.all.last.name
  end

  def test_it_knows_id
    assert_equal 263395237, @ir.all[0].id
    assert_equal 263396255, @ir.all.last.id
  end

  def test_it_knows_description
    assert_equal "Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden", @ir.all[1].description
    assert_equal 226, @ir.all.last.description.length
  end

  def test_it_knows_price
    assert_equal 12, @ir.all[0].unit_price.to_i
    assert_equal 149, @ir.all.last.unit_price.to_i
  end

  def test_it_knows_when_it_was_created
    assert_equal "2016-01-11 09:34:06 UTC", @ir.all[0].created_at.to_s
    assert_equal "2016-01-11 11:30:36 UTC", @ir.all.last.created_at.to_s
  end

  def test_it_knows_when_it_was_updated
    assert_equal "2007-06-04 21:35:10 UTC", @ir.all[0].updated_at.to_s
    assert_equal "1998-09-11 21:34:04 UTC", @ir.all.last.updated_at.to_s
  end

  def test_it_knows_merchant_id
    assert_equal 12334141, @ir.all[0].merchant_id
    assert_equal 12334195, @ir.all.last.merchant_id
  end

def test_items_know_merchants
  refute @ir.all[0].merchant.nil?
  refute @ir.all[0].merchant.eql?(@ir.all[1].merchant)
end

end
