require_relative './test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    iir = InvoiceItemRepository.new( "./data/test_invoice_items.csv" )

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_it_can_return_all_items
    iir = InvoiceItemRepository.new( "./data/test_invoice_items.csv" )
    invoice_items = iir.all.map do |invoice_item|
      invoice_item
    end
    assert_equal  1, invoice_items.first.id
  end

  def test_it_can_split_csv
    iir = InvoiceItemRepository.new( "./data/test_invoice_items.csv" )

    assert_equal 263519844, iir.all.first.item_id
  end

  def test_it_can_find_by_id
    iir = InvoiceItemRepository.new( "./data/test_invoice_items.csv" )

    expected = iir.all.first
    assert_equal expected, iir.find_by_id(1)
  end

  def test_can_find_all_by_item_id
    iir = InvoiceItemRepository.new( "./data/test_invoice_items.csv" )

    assert_equal 1, iir.find_all_by_item_id(263519844).first.id
    assert_instance_of Array, iir.find_all_by_item_id(1)
  end

  def test_can_find_all_by_invoice_id
    iir = InvoiceItemRepository.new( "./data/test_invoice_items.csv" )

    assert_equal 1, iir.find_all_by_invoice_id(1).first.id
    assert_instance_of Array, iir.find_all_by_invoice_id(1)
  end

  def test_it_can_create_item
    iir = InvoiceItemRepository.new
    iir.create({
      :id          => 100,
      :item_id     => 263000844,
      :invoice_id  => 100,
      :quantity    => 3,
      :unit_price  => BigDecimal.new("14000") / 100,
      :created_at  => Time.parse("2012-03-30 14:54:09 UTC"),
      :updated_at  => Time.parse("2010-03-27 14:54:09 UTC")
    })

    expected = iir.find_by_id(100)
    assert_equal expected, iir.all.last
    iir.create({
      :id          => 100,
      :item_id     => 263000844,
      :invoice_id  => 100,
      :quantity    => 3,
      :unit_price  => BigDecimal.new("14000") / 100,
      :created_at  => Time.parse("2012-03-30 14:54:09 UTC"),
      :updated_at  => Time.parse("2010-03-27 14:54:09 UTC")
    })

    expected = iir.find_by_id(101)
    assert_equal expected, iir.all.last
  end

  def test_it_can_update_attributes
    iir = InvoiceItemRepository.new( "./data/test_invoice_items.csv" )
    hash_2 = {
        :id          => 100,
        :item_id     => 263000844,
        :invoice_id  => 100,
        :quantity    => 3,
        :unit_price  => BigDecimal.new("14000") / 100,
        :created_at  => Time.parse("2012-03-30 14:54:09 UTC"),
        :updated_at  => Time.parse("2010-03-27 14:54:09 UTC")
      }
    iir.update(2, hash_2)

    assert_equal 2, iir.all.last.id
    assert_equal 263454779, iir.all.last.item_id
    assert_equal 1, iir.all.last.invoice_id
    assert_equal 3, iir.all.last.quantity
    assert_equal 140.00, iir.all.last.unit_price
    refute_equal Time.parse("2012-03-30 14:54:09 UTC"), iir.all.last.created_at
    refute_equal Time.parse("2010-03-27 14:54:09 UTC"), iir.all.last.updated_at
  end

  def test_it_can_delete_items
    iir = InvoiceItemRepository.new( "./data/test_invoice_items.csv" )
    iir.delete(2)

    assert_nil iir.find_by_id(2)
  end

end
