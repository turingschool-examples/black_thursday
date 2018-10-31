require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    iir = InvoiceItemRepository.new('./test/data/invoice_item_sample.csv')
    assert_instance_of InvoiceItemRepository, iir
  end

  def test_invoice_item_repo_has_repository_array_and_returns_all
    iir = InvoiceItemRepository.new('./test/data/invoice_item_sample.csv')
    assert_equal 10, iir.all.count
    assert_instance_of Array, iir.all
  end

  def test_it_can_find_by_invoice_item_by_id
    iir = InvoiceItemRepository.new('./test/data/invoice_item_sample.csv')
    item = iir.all[1]
    assert_equal item, iir.find_by_id(2)
    assert_instance_of InvoiceItem, iir.find_by_id(2)
  end

  def test_find_all_by_item_id
    iir = InvoiceItemRepository.new('./test/data/invoice_item_sample.csv')
    assert_equal 1, iir.find_all_by_item_id(263519844).count
  end

  def test_find_all_by_invoice_id
    iir = InvoiceItemRepository.new('./test/data/invoice_item_sample.csv')
    assert_equal 2, iir.find_all_by_invoice_id(2).count
  end

  def test_merchant_repo_can_create_an_invoice_item
    iir = InvoiceItemRepository.new('./test/data/customer_sample.csv')
    attributes = {
    item_id: 7,
    invoice_id: 8,
    quantity: 1,
    unit_price: BigDecimal(10.99, 4),
    created_at: Time.now,
    updated_at: Time.now
    }
    iir.create(attributes)
    invoice_item = iir.find_by_id(11)
    assert_equal 7, invoice_item.item_id
  end

  def test_we_can_update_attributes_for_invoice_item
    iir = InvoiceItemRepository.new('./test/data/customer_sample.csv')
    iir.create({:first_name => 'Larry'})
    iir.update(11, {:quantity => 14, :unit_price => BigDecimal(11.11, 4)})
    invoice_item = iir.find_by_id(11)
    assert_equal 14, invoice_item.quantity
    assert_equal 11.11, invoice_item.unit_price
    assert_instance_of Time, invoice_item.updated_at
  end


end
