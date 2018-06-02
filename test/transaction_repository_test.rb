require './test_helper'
require './lib/sales_engine'
require './lib/transaction_repository'
require 'bigdecimal'
require 'pry'


class TransactionRepositoryTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({
    :items => "./data/mock.csv",
    :merchants => "./data/mock.csv",
    :invoices => "./data/mock.csv",
    :invoice_items => "./data/mock.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/mock.csv"
    })

    @tr = se.transactions
    @transaction = @tr.find_by_id(2)
  end

  def test_find_transaction_by_id
    found_transaction = @tr.find_by_id(2)
    assert_equal 2, found_transaction.id
    assert_instance_of Transaction, found_transaction
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 2, @tr.find_all_by_invoice_id(2179).length
    assert_equal 2179, @tr.find_all_by_invoice_id(2179).first.invoice_id
    assert_instance_of Transaction, @tr.find_all_by_invoice_id(2179).first

    assert @tr.find_all_by_invoice_id(14560).empty?
  end

  def test_find_all_by_credit_card_number
    assert_equal 1, @tr.find_all_by_credit_card_number('4848466917766329').length
    assert_instance_of Transaction, @tr.find_all_by_credit_card_number('4848466917766329').first

    assert @tr.find_all_by_credit_card_number('4848466917766328').empty?
  end

  def test_find_all_by_result
    assert_equal 4158, @tr.find_all_by_result(:success).length
    assert_instance_of Transaction, @tr.find_all_by_result(:success).first

    assert_equal 827, @tr.find_all_by_result(:failed).length
    assert_instance_of Transaction, @tr.find_all_by_result(:failed).first
  end

  def test_it_can_create_new_transaction_instance
    attributes = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @tr.create(attributes)
    new_transaction = @tr.find_by_id(4986)
    assert_equal 8, new_transaction.invoice_id
  end

  def test_it_can_update_transaction
    attributes = {
          :invoice_id => 8,
          :credit_card_number => "4242424242424242",
          :credit_card_expiration_date => "0220",
          :result => "success",
          :created_at => Time.now,
          :updated_at => Time.now
        }

    @tr.create(attributes)

    new_attributes = {result: :failed}
    @tr.update(4986, new_attributes)


    assert_equal :failed, @tr.find_by_id(4986).result
    assert_equal '0220', @tr.find_by_id(4986).credit_card_expiration_date
    assert @tr.find_by_id(4986).created_at < @tr.find_by_id(4986).updated_at
  end

  def test_it_cant_update_transaction_id_invoice_id_created_at
  attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
        }

    @tr.create(attributes)

    new_attributes = {
      id: 5000,
      invoice_id: 2,
      created_at: Time.now
      }
    @tr.update(4986, new_attributes)


    assert_nil @tr.find_by_id(5000)
    refute_equal 2, @tr.find_by_id(4986).invoice_id
    refute_equal Time.now, @tr.find_by_id(4986).created_at
  end

  def test_it_can_delete_transaction
    attributes = {
          :invoice_id => 8,
          :credit_card_number => "4242424242424242",
          :credit_card_expiration_date => "0220",
          :result => "success",
          :created_at => Time.now,
          :updated_at => Time.now
        }
    @tr.create(attributes)
    assert_instance_of Transaction, @tr.find_by_id(4986)
    @tr.delete(4986)
    assert_nil @tr.find_by_id(4986)
  end

  def test_it_returns_nil_if_you_try_to_delete_nonexistant_ivoice_item
    assert_nil @tr.delete(5000)
  end

  def test_it_generates_table_of_transactions_and_their_results
    table = @tr.result_table
    assert_equal 3145, table.length
  end
end
