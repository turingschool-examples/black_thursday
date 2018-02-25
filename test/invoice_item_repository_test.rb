require './test/test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    file_name = './data/sample_data/invoice_items.csv'
    sales_eng = mock
    @invoice_item_repo = InvoiceItemRepository.new(file_name, sales_eng)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_item_repo
  end

  def test_it_finds_by_item_id
    actual  = @invoice_item_repo.find_all_by_item_id(4)
    actual2 = @invoice_item_repo.find_all_by_item_id(10)

    assert_instance_of Array, actual
    assert_equal 0, actual.length
    assert_equal 1, actual2.length
  end

  def test_it_finds_by_invoice_id
    actual  = @invoice_item_repo.find_all_by_invoice_id(4)
    actual2 = @invoice_item_repo.find_all_by_invoice_id(1)

    assert_instance_of Array, actual
    assert_equal 0, actual.length
    assert_equal 3, actual2.length
  end

  def test_inspect
    expected = '#<InvoiceItemRepository 4 rows>'
    assert_equal expected, @invoice_item_repo.inspect
  end
end
