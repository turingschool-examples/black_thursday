require_relative './test_helper'

class InvoiceItemRepositoryTest <Minitest::Test
  def test_it_exists
    iir = InvoiceItemRepository.new('./short_tests/short_invoice_item.csv')

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_it_can_find_all_by_item_id
    iir = InvoiceItemRepository.new('./short_tests/short_invoice_item.csv')

    invoice_item = iir.find_by_id(4)

    assert_equal [invoice_item], iir.find_all_by_item_id(263542298)
  end

  def test_it_can_find_all_by_invoice_id
    iir = InvoiceItemRepository.new('./short_tests/short_invoice_item.csv')

    invoice_item_1 = iir.find_by_id(9)
    invoice_item_2 = iir.find_by_id(10)

    assert_equal [invoice_item_1,invoice_item_2], iir.find_all_by_invoice_id(2)
  end

  def test_it_can_update_attributes
    iir = InvoiceItemRepository.new('./short_tests/short_invoice_item.csv')

    invoice_item_1 = iir.find_by_id(10)
    iir.update(10, {quantity: 5})

    assert_equal 5, invoice_item_1.quantity
  end

  def test_it_can_create_attributes
    iir = InvoiceItemRepository.new('./short_tests/short_invoice_item.csv')

    attributes = ({
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => 1099,
    :updated_at => "2017-01-11 12:29:33 UTC",
    :created_at => "2016-01-11 12:29:33 UTC"
    })
    iir.create(attributes)
    
    assert_equal 11, iir.repo.last.id
  end

end
