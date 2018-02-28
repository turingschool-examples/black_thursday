require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

# This is a class for tests of the invoice item repo class.
class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    invoice_item_csv = './test/fixtures/invoice_items_list_truncated.csv'
    parent = 'parent'
    @invoice_item_repo = InvoiceItemRepository.new(invoice_item_csv, parent)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_item_repo
  end

  def test_all_invoices
    assert_instance_of InvoiceItem, @invoice_item_repo.all.first
    assert_equal 23, @invoice_item_repo.all.length
  end

  def test_find_by_id
    assert_instance_of InvoiceItem, @invoice_item_repo.find_by_id(19)
    assert_equal 263_509_232, @invoice_item_repo.find_by_id(19).item_id
    assert_nil @invoice_item_repo.find_by_id(21)
  end

  def test_find_all_by_item_id
    actual = @invoice_item_repo.find_all_by_item_id(263_533_242)
    assert_instance_of Array, actual
    assert_equal 1, @invoice_item_repo.find_all_by_item_id(263_533_242).length
    actual = @invoice_item_repo.find_all_by_item_id(263_533_242)[0]
    assert_instance_of InvoiceItem, actual
    assert_equal [], @invoice_item_repo.find_all_by_item_id(263_503_202)
  end

  def test_find_all_by_invoice_id
    assert_instance_of Array, @invoice_item_repo.find_all_by_invoice_id(1)
    assert_equal 8, @invoice_item_repo.find_all_by_invoice_id(1).length
    actual = @invoice_item_repo.find_all_by_invoice_id(1).first
    assert_instance_of InvoiceItem, actual
    assert_equal [], @invoice_item_repo.find_all_by_invoice_id(4)
  end

  def test_find_all_by_multiple_invoice_ids
    invoice_id_array = [1, 2, 3]
    actual = @invoice_item_repo.find_all_by_mult_invoice_ids(invoice_id_array)

    assert_instance_of Array, actual
    assert_equal 3, actual.length
    assert_instance_of InvoiceItem, actual[0].flatten[0]

    invalid_inv_ids = [100, 103, 104]
    actual = @invoice_item_repo.find_all_by_mult_invoice_ids(invalid_inv_ids)
    assert_equal [], actual.flatten
  end

  def test_inspect
    assert_equal '#<InvoiceItemRepository 23 rows>', @invoice_item_repo.inspect
  end
end
