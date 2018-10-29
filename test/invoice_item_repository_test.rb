require './test/test_helper'
require './lib/invoice_item_repository'
require './lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup

#id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
#6,263539664,1,5,52100,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC

    @invoice_item_1 = InvoiceItem.new({
      :id          => 6,
      :item_id     => 263539664,
      :invoice_id  => 1,
      :quantity    => 5,
      :unit_price  => 52100,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
#7,263563764,1,4,66747,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC

    @invoice_item_2 = InvoiceItem.new({
      :id          => 7,
      :item_id     => 263563764,
      :invoice_id  => 1,
      :quantity    => 4,
      :unit_price  => 66747,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
#8,263432817,1,6,76941,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC

    @invoice_item_3 = InvoiceItem.new({
      :id          => 8,
      :item_id     => 263432817,
      :invoice_id  => 1,
      :quantity    => 6,
      :unit_price  => 76941,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    @iir = InvoiceItemRepository.new
    @iir.add_invoice_item(@invoice_item_1)
    @iir.add_invoice_item(@invoice_item_2)
    @iir.add_invoice_item(@invoice_item_3)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_it_can_add_invoice
    assert_equal [@invoice_item_1, @invoice_item_2, @invoice_item_3], @iir.all
  end

  def test_it_can_find_by_id
    assert_equal @invoice_item_1, @iir.find_by_id(6)
    assert_nil @iir.find_by_id(218319)
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal [@invoice_item_1, @invoice_item_2, @invoice_item_3], @iir.find_all_by_invoice_id(1)
    assert_equal [], @iir.find_all_by_invoice_id(963519845)
  end

  def test_it_can_find_by_item_id
    assert_equal [@invoice_item_1], @iir.find_all_by_item_id(263539664)
    assert_equal [], @iir.find_all_by_item_id(263553176)
  end


  def test_it_can_create_new_invoice_item_with_attributes
    @iir.create({
    :invoice_id  => 12,
    :item_id     => 8,
    :quantity    => 1,
    :unit_price  => BigDecimal.new(10.99, 4),
    :created_at  => Time.now,
    :updated_at  => Time.now})
    assert_equal 9, @iir.all.last.id
  end


  def test_it_can_update_invoice_with_attributes
    array = @iir.find_by_id(8)
    assert_equal 6, array.quantity
    attributes = {quantity: 7}
    @iir.update(8, attributes)
    assert_equal 7, array.quantity
  end

  def test_it_can_delete_invoice
    assert_equal @invoice_item_1, @iir.find_by_id(6)
    @iir.delete(6)
    assert_equal nil, @iir.find_by_id(6)
  end

end
