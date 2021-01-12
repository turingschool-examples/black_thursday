require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repository'
require './lib/transaction'
require 'time'
require 'bigdecimal'
require './lib/sales_engine'
require './lib/sales_analyst'

class TransactionRepoTest < Minitest::Test
  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    invoice_items_path = './data/invoice_items.csv'
    transaction_path = './data/mock_transactions.csv'
    customers_path = "./data/customers.csv"
    locations = { items: item_path,
                  merchants: merchant_path,
                  invoice_items: invoice_items_path,
                  transactions: transaction_path,
                  customers: customers_path}
    @engine = SalesEngine.new(locations)
    @transaction_repo = TransactionRepo.new('./data/mock_transactions.csv', @engine)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of TransactionRepo, @transaction_repo
    assert_equal './data/mock_transactions.csv', @transaction_repo.path
    assert_instance_of SalesEngine, @transaction_repo.engine
  end

  def test_it_can_return_all_invoice_items
    assert_instance_of Array, @transaction_repo.all
    assert_equal 29, @transaction_repo.all.length
  end

  def test_find_by_id
    assert_instance_of Transaction, @transaction_repo.find_by_id(3)
    assert_equal 750, @transaction_repo.find_by_id(3).invoice_id
  end

  def test_find_all_by_credit_card_number
    assert_instance_of Array, @transaction_repo.find_all_by_credit_card_number(4068631943231473)
    assert_equal 1, @transaction_repo.find_all_by_credit_card_number(4068631943231473).count
  end

  def test_find_all_by_result
    assert_instance_of Array, @transaction_repo.find_all_by_result("success")
    assert_equal  24, @transaction_repo.find_all_by_result("success").length
  end

  def test_create_creates_new_invoice_items
    attributes = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => "#{Time.now}",
      :updated_at => "#{Time.now}"
        }
      @transaction_repo.create(attributes)
    assert_instance_of Transaction, @transaction_repo.all.last
    assert_equal 30, @transaction_repo.all.length
  end

  def test_update_can_update_our_invoice_items
    attributes = {result: :failed}
    @transaction_repo.update(3, attributes)
    assert_equal :failed, @transaction_repo.find_by_id(3).result
  end

  def test_delete_can_delete_invoice_items
    assert_equal 3, @transaction_repo.find_by_id(3).id
    @transaction_repo.delete(3)
    assert_nil @transaction_repo.find_by_id(3)
  end
end
