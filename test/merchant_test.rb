require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/merchant_repository'
require 'csv'
class MerchantTest < Minitest::Test
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
    @mr = MerchantRepository.new('./data/merchants.csv', @engine)
    @m = Merchant.new({ id: 5, name: 'Turing School' }, @mr)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Merchant, @m
    assert_equal 5, @m.id
    assert_equal 'Turing School', @m.name
    assert_instance_of MerchantRepository, @m.merchant_repo
  end
end
