require_relative 'test_helper'
require './lib/invoice_item_repository'
require './lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @iir = InvoiceItemRepository.new()
  end

  def test_invoice_item_repository_class_exist
    assert_instance_of InvoiceItemRepository, @iir
  end
  
  def test_invoice_item_repository_begins_with_empty_array
    assert_equal [], @iir.data
  end

  def test_from_csv_populates_data
    @iir.from_csv("./test/fixtures/invoice_items_truncated_10.csv")

    assert_equal 10, @iir.data.count
  end

  def test_data_item_id_4_returns_correct_matching_item_id
    @iir.from_csv("./test/fixtures/invoice_items_truncated_10.csv")

    assert_equal "263542298", @iir.data[3].item_id
  end


end

