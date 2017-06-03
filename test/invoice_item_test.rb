require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_item'
require './lib/invoice_item_repository'
require 'pry'
class InvoiceItemTest < Minitest::Test

  def test_new_instance
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)
binding.pry
    assert_instance_of InvoiceItem, iir.contents[1]
  end
end
