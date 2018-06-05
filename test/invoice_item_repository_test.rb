require './test/test_helper.rb'
require './lib/invoice_item_repository.rb'
require './lib/file_loader.rb'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @iir = InvoiceItemRepository.new(load_file('./data/invoice_items_test.csv'))
    @attributes = {
      item_id: 7,
      invoice_id: 8,
      quantity: 1,
      unit_price: BigDecimal(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now
    }
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_it_can_return_entire_repository
    assert_equal @iir.repository, @iir.all
  end

  def test_it_can_find_by_id_number
    assert_equal @iir.all[0], @iir.find_by_id(1)
    assert_equal nil, @iir.find_by_id(25000)
  end

  def test_it_can_find_all_by_item_id
    assert_equal 1, @iir.find_all_by_item_id(263519844).count
    assert_equal [], @iir.find_all_by_item_id(10)
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 4, @iir.find_all_by_invoice_id(2).count
    assert_equal [], @iir.find_all_by_invoice_id('oops')
  end

  def test_it_can_create_a_new_entry
    new_invoice_item = @iir.create(@attributes)
    assert @iir.repository.include?(new_invoice_item)
    assert_equal new_invoice_item, @iir.find_by_id(102)
  end

  def test_it_can_update_an_entry
    @iir.create(@attributes)
    original_time = @iir.find_by_id(102).updated_at
    new_attributes = {
      quantity: 2,
      unit_price: BigDecimal(11.00, 4)
    }
    @iir.update(102, new_attributes)
    assert_equal 2, @iir.find_by_id(102).quantity
    assert_equal 11, @iir.find_by_id(102).unit_price
    assert @iir.find_by_id(102).updated_at > original_time
  end

  def test_it_can_delete_an_entry
    @iir.create(@attributes)
    @iir.delete(102)
    assert_equal nil, @iir.find_by_id(102)
  end
end
