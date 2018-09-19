require './test/helper'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
    :merchants     => './test/fixtures/merchants_fixtures.csv',
    :items         => './test/fixtures/items_fixtures.csv',
    :invoices      => './test/fixtures/invoices_fixtures.csv',
    :invoice_items => './test/fixtures/invoice_items_fixtures.csv'
                              })
    @i_i_r = se.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository,@i_i_r
  end

  def test_it_can_count_all_invoice_items
    assert_equal 14, @i_i_r.all.count
  end

  def test_it_find_by_id
    result = @i_i_r.find_by_id(1)
    assert_equal 1, result.id
  end

  def test_find_all_by_item_id
    result = @i_i_r.find_all_by_item_id(263515158)
    assert_equal 1, result.count
  end

  def test_it_can_find_all_by_invoice
    result = @i_i_r.find_all_by_invoice_id(1)
    assert_equal 8, result.count
  end

  def test_it_can_create_a_new_invoice_item
    new_invoice_item = @i_i_r.create({item_id: 263529299, quantity: 1})
    assert_equal 263529299, new_invoice_item.item_id
    assert_equal 15, new_invoice_item.id
  end

  def test_it_can_update_invoice_item_with_attributes
    @i_i_r.create({item_id: 263529299, quantity: 1})
    result = @i_i_r.update(15, {quantity: 3, unit_price: 4264})
    assert_equal 3, result.quantity
    assert_equal 4264, result.unit_price
  end

  def test_it_can_be_deleted
    @i_i_r.create({item_id: 263529299, quantity: 1})
    assert_equal 15, @i_i_r.invoice_items.length
    @i_i_r.delete(15)
    assert_equal 14, @i_i_r.invoice_items.length
  end
end
