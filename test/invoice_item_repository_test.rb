require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items.csv')
    assert_instance_of InvoiceItemRepository, iir
  end

  def test_it_has_items
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items.csv')
    assert_equal 1000, iir.all.count

    assert_equal 1, iir.all.first.id
  end

  def test_it_can_find_item_by_id
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items.csv')

    actual = iir.find_by_id(1)

    assert_instance_of InvoiceItem, actual
    assert_equal 1, actual.id
  end

  def test_returns_nil_when_no_match_is_found
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items.csv')

    actual = iir.find_by_id(99999)

    assert_nil actual
  end

  def test_it_can_find_all_by_item_id
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items.csv')
    expected = [iir.all[0]]

    assert_equal expected, iir.find_all_by_item_id(263519844)
    assert_equal 2, iir.find_all_by_item_id(263454779).count
    assert_equal [], iir.find_all_by_item_id(123)
  end

  def test_it_can_find_all_by_invoice_id
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items.csv')
    expected = [iir.all[82]]

    assert_equal expected, iir.find_all_by_invoice_id(16)
    assert_equal 8, iir.find_all_by_invoice_id(1).count
    assert_equal [], iir.find_all_by_invoice_id(00)
  end

  def test_it_can_create_new_invoice_items
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items.csv')

    new_item = iir.create(item_id: 10000,
                          invoice_id: 1000,
                          quantity: 10,
                          unit_price: BigDecimal.new(10.99, 4),
                          created_at: Time.now,
                          updated_at: Time.now)

    assert_instance_of InvoiceItem, new_item

    actual = [iir.all.last]

    assert_equal iir.find_all_by_item_id(10000), actual
    assert_equal iir.find_all_by_invoice_id(1000), actual
  end

  def test_item_attributes_can_be_updated
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items.csv')

    actual = iir.find_by_id(1)

    assert_equal 263519844, actual.item_id
    assert_equal 5, actual.quantity

    id = (1)
    attributes = {quantity: 6,
                  unit_price: 11.99}

    iir.update(id, attributes)

    assert_equal 6, iir.find_by_id(id).quantity
    assert_equal 11.99, iir.find_by_id(id).unit_price
  end

  def test_repo_can_delete_items
    iir = InvoiceItemRepository.new('./test/fixtures/invoice_items.csv')

    iir.delete(1)

    assert_nil iir.find_by_id(1)
  end

end
