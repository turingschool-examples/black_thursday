require 'time'
require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @sample_data = './test/fixtures/sample_invoice_items.csv'
  end

  def test_class_exists
    invoice_item_repo = InvoiceItemRepository.new(@sample_data, 'engine')

    assert_instance_of InvoiceItemRepository, invoice_item_repo
  end

  def test_all
    invoice_item_repo = InvoiceItemRepository.new(@sample_data, 'engine')

    assert_equal 10, invoice_item_repo.all.count
  end

  def test_find_by_id
    invoice_item_repo = InvoiceItemRepository.new(@sample_data, 'engine')

    assert_nil invoice_item_repo.find_by_id(20)
    assert_equal invoice_item_repo.invoice_items[3], invoice_item_repo.find_by_id(4)
  end

  def test_find_all_by_item_id
    invoice_item_repo = InvoiceItemRepository.new(@sample_data, 'engine')

    expected = [invoice_item_repo.invoice_items[4], invoice_item_repo.invoice_items[9]]

    assert_equal expected, invoice_item_repo.find_all_by_item_id(263523644)
    assert_equal [], invoice_item_repo.find_all_by_item_id(163315150)
  end

  def test_find_all_by_invoice_id
    invoice_item_repo = InvoiceItemRepository.new(@sample_data, 'engine')

    expected = [invoice_item_repo.invoice_items[8], invoice_item_repo.invoice_items[9]]

    assert_equal expected, invoice_item_repo.find_all_by_invoice_id(2)
      assert_equal [], invoice_item_repo.find_all_by_item_id(3)
  end

  def test_create_with_attrs_arg
    invoice_item_repo = InvoiceItemRepository.new(@sample_data, 'engine')

    attributes = {
                   :id          => '11',
                   :item_id     => '263523648',
                   :invoice_id  => '2',
                   :quantity    => '10',
                   :unit_price  => BigDecimal(3.99,4),
                   :created_at  => Time.now,
                   :updated_at  => Time.now
                 }
    invoice_item_repo.create(attributes)

    assert_equal invoice_item_repo.invoice_items.last, invoice_item_repo.find_by_id(11)
    assert_equal 11, invoice_item_repo.all.count
  end

  def test_max_invoice_item_id
    invoice_item_repo = InvoiceItemRepository.new(@sample_data, 'engine')

    assert_equal 10, invoice_item_repo.max_invoice_item_id
  end

  def test_update_with_id_and_attrs_arg
    invoice_item_repo = InvoiceItemRepository.new(@sample_data, 'engine')
    original_time = invoice_item_repo.find_by_id(2).updated_at
    update = {
              quantity:   12,
              unit_price: 20
              }
    invoice_item_repo.update(2, update)

    assert_equal 12, invoice_item_repo.invoice_items[1].quantity
    assert_equal 20, invoice_item_repo.invoice_items[1].unit_price
  end

  def test_delete_with_id_arg
    invoice_item_repo = InvoiceItemRepository.new(@sample_data, 'engine')

    invoice_item_repo.delete(9)

    assert_nil invoice_item_repo.find_by_id(9)
  end
end
