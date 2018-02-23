require './test/test_helper'
require './lib/invoice_item_repository'
require './lib/sales_engine'
require './lib/searching'

class InvoiceItemRepositoryTest < Minitest::Test
  # def setup
  #   file_name = './data/sample_data/invoices.csv'
  #   @invoice_items = InvoiceItemRepository.new(file_name)
  # end

  def test_it_exists
      assert_instance_of InvoiceItemRepository, @invoice_items
  end
end
