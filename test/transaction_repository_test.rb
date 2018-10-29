require_relative './test_helper'

class TransactionRepositoryTest < Minitest::Test
    
    def setup
      time = Time.now.to_s
      @t_1 = Transaction.new({
                          :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => time,
                          :updated_at => time
                        })
      @t_2 = Transaction.new({
                          :id => 7,
                          :invoice_id => 8,
                          :credit_card_number => "4613250127567219",
                          :credit_card_expiration_date => "0223",
                          :result => "failed",
                          :created_at => time,
                          :updated_at => time
                        })
      @t_3 = Transaction.new({
                          :id => 8,
                          :invoice_id => 10,
                          :credit_card_number => "4558368405929183",
                          :credit_card_expiration_date => "0417",
                          :result => "success",
                          :created_at => time,
                          :updated_at => time
                        })
      @transactions = [@t_1, @t_2, @t_3]
      @tr = TransactionRepository.new(@transactions)
    end
    
    def test_it_exists
      assert_instance_of TransactionRepository, @tr
    end
    
    def test_it_can_be_created_by_sales_engine
      sales_engine = SalesEngine.from_csv(:transactions => "./data/transactions.csv")
      
      assert_instance_of TransactionRepository, sales_engine.transactions
    end
    
    def test_it_can_return_all_transactions
      assert_equal @transactions, @tr.all
    end
    
    def test_it_can_find_transaction_by_id
      assert_nil @tr.find_by_id(47)
      assert_equal @t_1, @tr.find_by_id(6)
    end
    
    def test_it_can_find_all_by_invoice_id
      assert_equal [], @tr.find_all_by_invoice_id(47)
      assert_equal [@t_1, @t_2], @tr.find_all_by_invoice_id(8)
    end
    
    def test_it_can_find_all_by_credit_card_number
      assert_equal [], @tr.find_all_by_credit_card_number("1234")
      assert_equal [@t_2], @tr.find_all_by_credit_card_number("4613250127567219")
    end
    
    def test_it_can_find_all_by_result_status
      assert_equal [], @tr.find_all_by_result(:test)
      assert_equal [@t_1, @t_3], @tr.find_all_by_result(:success)
    end
    
    def test_it_can_create_new_transaction
      attributes = {
                    :invoice_id => 10,
                    :credit_card_number => "4558368405929183",
                    :credit_card_expiration_date => "0417",
                    :result => "success"
                  }
      transaction = @tr.create(attributes)
      assert_equal [@t_1, @t_2, @t_3, transaction], @tr.all
      assert_equal 10, transaction.invoice_id
      assert_equal "4558368405929183", transaction.credit_card_number
      assert_equal "0417", transaction.credit_card_expiration_date
      assert_equal :success, transaction.result
      assert_equal 9, transaction.id
      assert transaction.created_at
      assert transaction.updated_at
    end
    
    def test_it_can_update_transactions
      original_updated_at = @t_1.updated_at
      @tr.update(6, {
                  :credit_card_number => "4558368405929867",
                  :credit_card_expiration_date => "0517",
                  :result => "failed"
                  })
      assert_equal 6, @t_1.id
      assert_equal 8, @t_1.invoice_id
      assert_equal "4558368405929867", @t_1.credit_card_number
      assert_equal "0517", @t_1.credit_card_expiration_date
      assert_equal "failed", @t_1.result
      updated_at = @t_1.updated_at > original_updated_at
      assert updated_at
      
      @tr.update(8, {result: "failed"})
      assert_equal "failed", @t_3.result
      assert_equal "4558368405929183", @t_3.credit_card_number
    end
    
    def test_it_can_delete_transactions
      expected = [@t_1, @t_3]
      @tr.delete(7)
      assert_equal expected, @tr.all
    end
end
