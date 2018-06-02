require './test/test_helper.rb'
require './lib/invoice_item_repository.rb'
require './lib/file_loader.rb'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test
  include FileLoader

  def test_it_exists
    iir = InvoiceItemRepository.new(load_file("./data/invoice_items_test.csv"))
    assert_instance_of InvoiceItemRepository, iir
  end

  def test_it_can_return_entire_repository
    iir = InvoiceItemRepository.new(load_file("./data/invoice_items_test.csv"))
    assert_equal iir.repository, iir.all
  end

  def test_it_can_find_by_id_number
    iir = InvoiceItemRepository.new(load_file("./data/invoice_items_test.csv"))
    assert_equal iir.all[0], iir.find_by_id(1)
    assert_equal nil, iir.find_by_id(25000)
  end

  def test_it_can_find_all_by_item_id
    iir = InvoiceItemRepository.new(load_file("./data/invoice_items_test.csv"))
    assert_equal 1, iir.find_all_by_item_id(263519844).count
    assert_equal [], iir.find_all_by_item_id(10)
  end

  def test_it_can_find_all_by_invoice_id
    iir = InvoiceItemRepository.new(load_file("./data/invoice_items_test.csv"))
    assert_equal 4, iir.find_all_by_invoice_id(2).count
    assert_equal [], iir.find_all_by_invoice_id('oops')
  end

  def test_it_can_create_a_new_entry
    iir = InvoiceItemRepository.new(load_file("./data/invoice_items_test.csv"))
    attributes = ({
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
    new_invoice_item = iir.create(attributes)
    sorted = iir.repository.sort_by { |invoice_item| invoice_item.id }
    assert iir.repository.include?(new_invoice_item)
    assert_equal new_invoice_item, iir.find_by_id(102)
  end

  def test_it_can_update_an_entry
    iir = InvoiceItemRepository.new(load_file("./data/invoice_items_test.csv"))
    attributes = ({
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
    new_invoice_item = iir.create(attributes)
    original_time = iir.find_by_id(102).updated_at
    new_attributes = {
      :quantity => 2,
      :unit_price => BigDecimal.new(11.00,4)
    }
    id = 102
    iir.update(id, new_attributes)
    assert_equal 2, iir.find_by_id(id).quantity
    assert_equal 11, iir.find_by_id(id).unit_price
    assert iir.find_by_id(id).updated_at > original_time
  end

  def test_it_can_delete_an_entry
    iir = InvoiceItemRepository.new(load_file("./data/invoice_items_test.csv"))
    attributes = ({
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
    new_invoice_item = iir.create(attributes)
    iir.delete(102)
    assert_equal nil, iir.find_by_id(102)
  end

end
