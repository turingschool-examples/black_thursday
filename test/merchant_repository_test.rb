require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/merchant'
require './lib/sales_engine'
require 'csv'
class MerchantRepositoryTest < Minitest::Test
  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    invoice_items_path = './data/invoice_items.csv'
    customers_path = "./data/customers.csv"
    transactions_path = "./data/transactions.csv"
    invoices_path = './data/invoices.csv'
    locations = { items: item_path,
                  merchants: merchant_path,
                  invoice_items: invoice_items_path,
                  customers: customers_path,
                  transactions: transactions_path,
                  invoices: invoices_path}
    @engine = SalesEngine.new(locations)
    @mr = MerchantRepository.new('./data/merchants.csv', @engine)
    @merchants = []
    @m = Merchant.new({ id: 12_334_112, name: 'Candisart' }, @mr)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of MerchantRepository, @mr
    assert_instance_of SalesEngine, @engine
    assert_equal './data/merchants.csv', @mr.path
  end

  def test_it_can_read_merchants
    assert_equal 475, @mr.merchants.count
  end

  def test_it_can_return_all
    assert_instance_of Merchant, @mr.all[0]
  end

  def test_find_by_id
    assert_equal 'Candisart', @mr.find_by_id(12_334_112).name
    assert_equal 'CJsDecor', @mr.find_by_id(12_337_411).name
    assert_nil @mr.find_by_id(1_233_741)
  end

  def test_find_by_name
    assert_equal 12_334_112, @mr.find_by_name('Candisart').id
    assert_nil @mr.find_by_name('abc')
  end

  def test_find_all_by_name
    assert_equal [@m].count, @mr.find_all_by_name('andisar').count
    assert_equal [], @mr.find_all_by_name('abc')
  end

  def test_create_attributes_adds_merchant_objects
    @mr.create({ name: 'Ruby' })
    assert_equal 12_337_412, @mr.merchants.last.id
  end

  def test_update_changes_merchant_object_names
    attributes = {name: "Harry's Appliances" }
    @mr.update(12_334_112, attributes)
    assert_equal "Harry's Appliances", @mr.find_by_id(12_334_112).name
  end

  def test_delete_removes_merchant_object
    @mr.delete(12_334_112)
    assert_nil @mr.find_by_id(12_334_112)
  end
end
