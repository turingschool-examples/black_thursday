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

end
