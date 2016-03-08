
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryClassTest < Minitest::Test

  def setup
    sales_engine = "sales_engine"
    @transactions = TransactionRepository.new(sales_engine)
    @transactions.repository << Transaction.new(sales_engine, {:id => '1',
      :invoice_id => '2179',
      :credit_card_number => '4068631943231473',
      :credit_card_expiration_date => '0217',
      :result => 'success',
      :created_at => '2012-02-26 20:56:56 UTC',
      :updated_at => '2012-02-26 20:56:56 UTC'})
    @transactions.repository << Transaction.new(sales_engine, {:id => '2',
      :invoice_id => '46',
      :credit_card_number => '4177816490204479',
      :credit_card_expiration_date => '0813',
      :result => 'success',
      :created_at => '2012-02-26 20:56:56 UTC',
      :updated_at => '2012-02-26 20:56:56 UTC'})
  end

  def test_we_can_create_an_invoice_repository
    assert @invoice_items
    assert_equal 2, @invoice_items.all.count
  end

  def test_we_can_find_invoice_items_by_id # test
    assert_equal Array, @invoice_items.find_all_by_item_id(263519844).class
    assert_equal 263519844, @invoice_items.find_by_id(1).item_id
    assert_equal  263454779, @invoice_items.find_by_id(2).item_id
  end

  def test_we_can_find_all_by_item_id # edit test 
    assert_equal 1, @invoice_items.find_all_by_item_id(263519844)[0].id
    assert_equal 2, @invoice_items.find_all_by_item_id(263454779)[0].id
  end

  def test_we_can_find_all_by_invoice_id # edit test
    assert_equal [1, 2], @invoice_items.find_all_by_invoice_id(1).map { |invoice_item| invoice_item.id}
  end
end
