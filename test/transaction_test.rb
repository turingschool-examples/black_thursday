require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repository'
require './lib/transaction'
require 'time'
require 'bigdecimal'
require './lib/sales_engine'
require './lib/sales_analyst'

class TransactionTest < Minitest::Test
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
    @transaction_repo = TransactionRepo.new('./data/transactions.csv', @engine)
    @t = Transaction.new({
                          :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => "#{Time.now}",
                          :updated_at => "#{Time.now}"
                        },@transaction_repo)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Transaction, @t
    assert_equal 6, @t.id
    assert_equal 8, @t.invoice_id
    assert_equal 4242424242424242, @t.credit_card_number
    assert_equal "success", @t.result
    assert_instance_of Time, @t.created_at
    assert_instance_of Time, @t.updated_at
    assert_instance_of TransactionRepo, @t.transaction_repo
  end
end
