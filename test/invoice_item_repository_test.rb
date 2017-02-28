require './test/test_helper.rb'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test
    def setup
    @invoice_item_csv =  './test/fixtures/invoice_items.csv'
    @parent = ""
  end
  def test_it_exists
    assert_instance_of InvoiceItemRepository, InvoiceItemRepository.new(@invoice_item_csv, nil)
  end

  def test_all_array
    repo = InvoiceItemRepository.new(@invoice_csv, @parent)
    # repo.make_repository
    assert_equal 4985, repo.all.length
  end

  
end