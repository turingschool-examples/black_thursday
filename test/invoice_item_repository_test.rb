require 'bigdecimal'
require 'csv'
require_relative 'test_helper'
require_relative '../lib/repositories/invoice_item_repository'
require_relative '../lib/file_io'

# Test for InvoiceItem Repository class
class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    invoice_item_data = invoice_items
    csv = parse_data(invoice_item_data)
    @inv_i_repo = InvoiceItemRepository.new(csv)
    @time = Time.now
    @invoice_item1 = @inv_i_repo.invoice_items[1]
    @invoice_item2 = @inv_i_repo.invoice_items[2]
    @invoice_item3 = @inv_i_repo.invoice_items[3]
    @invoice_item11 = @inv_i_repo.invoice_items[11]
    @invoice_item12 = @inv_i_repo.invoice_items[12]
    @invoice_item13 = @inv_i_repo.invoice_items[13]
    @invoice_item14 = @inv_i_repo.invoice_items[14]
  end

  def test_invoice_item_repository_exists
    assert_instance_of InvoiceItemRepository, @inv_i_repo
  end

  def test_creating_an_index_of_invoice_items_from_data
    expected = { 1 => @invoice_item1, 2 => @invoice_item2,
                 3 => @invoice_item3, 11 => @invoice_item11,
                 12 => @invoice_item12, 13 => @invoice_item13,
                 14 => @invoice_item14 }
    assert_equal expected, @inv_i_repo.invoice_items
  end

  def test_all_returns_an_array_of_all_invoice_item_instances
    assert_equal [@invoice_item1, @invoice_item2, @invoice_item3,
                  @invoice_item11, @invoice_item12, @invoice_item13,
                  @invoice_item14], @inv_i_repo.all
  end

  def test_can_find_by_id
    actual_one = @inv_i_repo.find_by_id(1)
    actual_two = @inv_i_repo.find_by_id(2)
    assert_equal @invoice_item1, actual_one
    assert_equal @invoice_item2, actual_two
  end

  def test_can_find_all_by_item_id
    actual = @inv_i_repo.find_all_by_item_id(263438971)
    assert_equal [@invoice_item12, @invoice_item14], actual
  end

  def test_can_find_all_by_invoice_id
    actual = @inv_i_repo.find_all_by_invoice_id(1)
    assert_equal [@invoice_item1, @invoice_item2, @invoice_item3], actual
  end

  def test_it_can_generate_next_invoice_item_id
    expected = 15
    actual = @inv_i_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_invoice_item
    a_new_invoice_item = new_invoice_item
    assert_equal 8, @inv_i_repo.invoice_items.count
    assert_equal a_new_invoice_item, @inv_i_repo.invoice_items[15]
  end

  def test_invoice_item_can_be_updated
    @inv_i_repo.update(14, quantity: 52)
    assert_equal 52, @inv_i_repo.invoice_items[14].quantity
    @inv_i_repo.update(13, unit_price: 332.45)
    assert_equal 332.45, @inv_i_repo.invoice_items[13].unit_price
  end

  def test_invoice_item_can_be_deleted
    @inv_i_repo.delete(14)
    assert_equal 6, @inv_i_repo.invoice_items.count
    assert_nil @inv_i_repo.invoice_items[14]
  end

  def test_magic_spec_harness_method_works
    expected = '#<InvoiceItemRepository 7 rows>'
    assert_equal expected, @inv_i_repo.inspect
  end

  def new_invoice_item
    @inv_i_repo.create(item_id: '263454000', invoice_id: '1',
                       quantity: '100',
                       unit_price: '23324',
                       created_at: '2012-03-27 14:54:09 UTC',
                       updated_at: '2014-03-27 14:54:09 UTC')
  end

  def invoice_items
    %(id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
    1,263519844,1,5,13635,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    2,263454779,1,9,23324,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    3,263451719,1,8,34873,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    11,263532898,2,3,30949,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    12,263438971,2,8,31099,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    13,263553176,3,4,78660,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    14,263438971,4,12,31099,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC)
  end

  def parse_data(data)
    CSV.parse(data, headers: :true, header_converters: :symbol)
  end
end
