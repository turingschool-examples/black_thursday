require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'
require './lib/sales_engine'
require './lib/sales_analyst'
require './lib/invoice_item'
require 'time'
require 'bigdecimal'
class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    invoice_items_path = './data/invoice_items.csv'
    customers_path = './data/customers.csv'
    transactions_path = './data/transactions.csv'
    invoices_path = './data/invoices.csv'
    locations = { items: item_path,
                  merchants: merchant_path,
                  invoice_items: invoice_items_path,
                  customers: customers_path,
                  transactions: transactions_path,
                  invoices: invoices_path }
    @engine = SalesEngine.new(locations)
    @invoice_item_repo = InvoiceItemRepository.new('./data/mock_invoice_items.csv', @engine)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of InvoiceItemRepository, @invoice_item_repo
    assert_equal './data/mock_invoice_items.csv', @invoice_item_repo.path
    assert_instance_of SalesEngine, @invoice_item_repo.engine
  end

  def test_it_can_return_all_invoice_items
    assert_instance_of Array, @invoice_item_repo.all
    assert_equal 19, @invoice_item_repo.all.length
  end

  def test_find_by_id
    assert_instance_of InvoiceItem, @invoice_item_repo.find_by_id(3)
    assert_equal 263_451_719, @invoice_item_repo.find_by_id(3).item_id
  end

  def test_find_all_by_item_id
    assert_instance_of Array, @invoice_item_repo.find_all_by_item_id(263_515_158)
    assert_equal 1, @invoice_item_repo.find_all_by_item_id(263_454_779).count
  end

  def test_find_all_by_invoice_id
    assert_instance_of Array, @invoice_item_repo.find_all_by_invoice_id(1_234_567_890)
    assert_equal 4, @invoice_item_repo.find_all_by_invoice_id(2).count
  end

  def test_create_creates_new_invoice_items
    attributes = {
      item_id: 7,
      invoice_id: 8,
      quantity: 1,
      unit_price: BigDecimal(10.99, 4),
      created_at: Time.now.to_s,
      updated_at: Time.now.to_s
    }
    @invoice_item_repo.create(attributes)
    assert_instance_of InvoiceItem, @invoice_item_repo.all.last
    assert_equal 20, @invoice_item_repo.all.length
  end

  def test_update_can_update_our_invoice_items
    attributes = { quantity: 13 }
    @invoice_item_repo.update(3, attributes)
    assert_equal 13, @invoice_item_repo.find_by_id(3).quantity
  end

  def test_delete_can_delete_invoice_items
    assert_equal 3, @invoice_item_repo.find_by_id(3).id
    @invoice_item_repo.delete(3)
    assert_nil @invoice_item_repo.find_by_id(3)
  end
end
