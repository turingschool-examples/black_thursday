require './test/test_helper'
require './lib/invoice_item_repository'
require 'csv'
require 'bigdecimal'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @inv_items = CSV.open './data/invoice_item_test.csv',
                          headers: true,
                          header_converters: :symbol
    @iir = InvoiceItemsRepository.new
  end

  def test_it_exists
    assert_instance_of InvoiceItemsRepository, @iir
  end

  def test_all_defaults_empty
    assert_equal [], @iir.all
  end

  def test_loads_csv
    @iir.load_invoice_items(@inv_items)
    assert_equal 12, @iir.all.length
  end

  def test_invoice_item_can_be_found_by_id
    @iir.load_invoice_items(@inv_items)

    assert_equal 263_529_264, @iir.find_by_id(9).item_id
    assert_nil @iir.find_by_id(123_467)
  end

  def test_find_all_by_item_id
    @iir.load_invoice_items(@inv_items)

    assert_equal 3, @iir.find_all_by_item_id(263_529_264).length
    assert_equal 0, @iir.find_all_by_item_id(1984).length
  end

  def test_find_all_by_invoice_id
    @iir.load_invoice_items(@inv_items)

    assert_equal 8, @iir.find_all_by_invoice_id(1).length
    assert_equal 0, @iir.find_all_by_invoice_id(0).length
  end

  def test_create
    @iir.load_invoice_items(@inv_items)

    attributes = {
      item_id: '89743578971234',
      invoice_id: '2',
      quantity: '500',
      unit_price: BigDecimal(1.59, 3),
      created_at: Time.now,
      updated_at: Time.now
    }

    @iir.create(attributes)

    assert_equal 13, @iir.all.last.id
    assert_equal 89_743_578_971_234, @iir.all.last.item_id
    assert_equal 2, @iir.all.last.invoice_id
    assert_equal 500, @iir.all.last.quantity
    assert_equal 1.59, @iir.all.last.unit_price
    assert_instance_of Time, @iir.all.last.created_at
    assert_instance_of Time, @iir.all.last.updated_at
  end

  def test_update
    @iir.load_invoice_items(@inv_items)

    id = 12

    attributes = { quantity: 746,
                   unit_price: 10.99 }

    @iir.update(id, attributes)

    assert_equal 12, @iir.find_by_id(12).id
    assert_equal 263_529_264, @iir.find_by_id(12).item_id
    assert_equal 2, @iir.find_by_id(12).invoice_id
    assert_equal 746, @iir.find_by_id(12).quantity
    assert_equal 10.99, @iir.find_by_id(12).unit_price

    created_time = @iir.find_by_id(12).created_at
    updated_time = @iir.find_by_id(12).updated_at

    assert updated_time > created_time
  end

  def test_delete
    @iir.load_invoice_items(@inv_items)

    assert_equal 12, @iir.all.length

    @iir.delete(12)

    assert_equal 11, @iir.all.length
  end
end
