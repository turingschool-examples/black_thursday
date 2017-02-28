require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @iir = InvoiceItemRepository.new
    @iir.from_csv("./data/invoice_items_fixture.csv")
    @inv_item = @iir.all[0]
    binding.pry
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_initializes_with_empty_array
    iir = InvoiceItemRepository.new
    assert_equal [], iir.all
  end

  def test_from_csv_populates_array
    iir = InvoiceItemRepository.new
    iir.from_csv("./data/invoice_items_fixture.csv")
    refute iir.all.empty?
    assert_instance_of InvoiceItem, iir.all[0]
  end

# # #Refactor headers test
# #   def test_can_pull_csv_headers
# #     skip
# #     ir = ItemRepository.new(@path)
# #     name = nil
# #     merchant_id = nil
# #     @path.each do |row|
# #      name = row[:name]
# #      merchant_id = row[:merchant_id]
# #     end
# #     assert_equal "Disney scrabble frames
# #     assert_equal "12334185", merchant_id
# #   end

  def test_can_return_all_invoice_items
    assert_equal 30, @iir.all.length
  end

  def test_can_find_by_id
    found = @iir.find_by_id(7)
    not_found = @iir.find_by_id(9999999)

    assert_equal 7, found.id
    assert_nil not_found
  end

#   def test_can_find_by_description
#     ir = ItemRepository.new(@path)
#     found = @iir.find_all_with_description("This is THE DESCRiption")
#     assert_equal "this is the description", found[0].description
#   end

  def test_can_find_all_by_item_id
    found = @iir.find_all_by_item_id(263529264)
    not_found = @iir.find_all_by_item_id(9999999)

#which is better, line 66 or 76?:
    assert_instance_of InvoiceItem, found[0]
    assert_equal 2, found.count
    assert_equal [], not_found
  end


  def test_can_find_all_by_invoice_id
    found = @iir.find_all_by_invoice_id(1)
    not_found = @iir.find_all_by_invoice_id(9999999)

    assert found.all?{ |invoice| invoice.is_a?(InvoiceItem)}
    assert_equal 8, found.count
    assert_equal [], not_found
  end

#   def test_can_find_all_by_price_in_range
#     ir = ItemRepository.new(@path)
#     found = @iir.find_all_by_price_in_range((11.00..14.00))
#     not_found = @iir.find_all_by_price_in_range((1.0..2.5))


#     assert_instance_of Array, found
#     assert_equal 12.00, found[0].unit_price
#     assert_equal 13.50, found[1].unit_price
#     assert_equal [], not_found
#   end

# #note: found.count depends on fixtures file. Update.
#   def test_can_find_all_by_merchant_id
#     ir = ItemRepository.new(@path)
#     found = @iir.find_all_by_merchant_id(12334185)
#     assert_equal 12334185, found[0].merchant_id
#     assert_equal 2, found.count
#   end


end
