require_relative 'test_helper'
require_relative '../lib/transaction_repo'

class TransactionRepoTest < Minitest::Test

  def setup
    transaction_array = [{:id=>"1", :invoice_id=>"2170", :credit_card_number=>"4068631943231473", :credit_card_expiration_date=>"0217", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"}, 
    {:id=>"2", :invoice_id=>"2179", :credit_card_number=>"4068631943231474", :credit_card_expiration_date=>"0217", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"}, 
    {:id=>"3", :invoice_id=>"2178", :credit_card_number=>"4068631943231474", :credit_card_expiration_date=>"0217", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"}, 
    {:id=>"4", :invoice_id=>"2179", :credit_card_number=>"4068631943231475", :credit_card_expiration_date=>"0217", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"}, 
    {:id=>"5", :invoice_id=>"2180", :credit_card_number=>"4068631943231476", :credit_card_expiration_date=>"0217", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
    {:id=>"6", :invoice_id=>"2171", :credit_card_number=>"4068631943231477", :credit_card_expiration_date=>"0217", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
    {:id=>"7", :invoice_id=>"2172", :credit_card_number=>"4068631943231478", :credit_card_expiration_date=>"0217", :result=>"failed", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
    {:id=>"8", :invoice_id=>"2173", :credit_card_number=>"4068631943231479", :credit_card_expiration_date=>"0217", :result=>"failed", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"}]
    @transaction_repo = TransactionRepo.new(transaction_array)
  end 

  def test_it_exists
    assert_instance_of TransactionRepo, @transaction_repo
  end

  def test_it_returns_all_items
    assert_equal @transaction_repo.transactions, @transaction_repo.all
  end
 
  def test_it_finds_transaction_by_id
    assert_equal @transaction_repo.transactions[0], @transaction_repo.find_by_id(1)
    assert_equal nil, @transaction_repo.find_by_id(123456)
  end

  def test_it_finds_all_transactions_by_invoice_id
    assert_equal [@transaction_repo.transactions[1], @transaction_repo.transactions[3]], @transaction_repo.find_all_by_invoice_id(2179)
    assert_equal [], @transaction_repo.find_all_by_invoice_id(1234)
  end

  def test_it_finds_all_transactions_by_credit_card_number
    assert_equal [@transaction_repo.transactions[1], @transaction_repo.transactions[2]], @transaction_repo.find_all_by_credit_card_number("4068631943231474")
    assert_equal [], @transaction_repo.find_all_by_credit_card_number("1234567891011124")
  end

  def test_it_finds_all_transactions_by_result
    assert_equal [@transaction_repo.transactions[6], @transaction_repo.transactions[7]], @transaction_repo.find_all_by_result("failed")
    assert_equal [], @transaction_repo.find_all_by_result("pending")
  end

  def test_it_creates_transaction_with_attributes
    refute_instance_of Transaction, @transaction_repo.transactions[8]

    @transaction_repo.create({:id => 9,
                              :invoice_id => 8,
                              :credit_card_number => "4242424242424242",
                              :credit_card_expiration_date => "0220",
                              :result => "success",
                              :created_at => Time.now,
                              :updated_at => Time.now
                             })

    assert_instance_of Transaction, @transaction_repo.transactions[8]
  end

  def test_it_updates_transaction_attributes
    refute_equal "424242424242424", @transaction_repo.transactions[7].credit_card_number
    refute_equal "0220", @transaction_repo.transactions[7].credit_card_expiration_date
    refute_equal  "success", @transaction_repo.transactions[7].result
  
    current_time = Time.now.to_s
  
    @transaction_repo.update(8, {:id => 9,
                                 :invoice_id => 2222,
                                 :credit_card_number => "4242424242424242",
                                 :credit_card_expiration_date => "0220",
                                 :result => "success",
                                 :created_at => Time.now,
                                 :updated_at => current_time
                                })
  
    assert_equal "424242424242424", @transaction_repo.transactions[7].credit_card_number
    assert_equal "0220", @transaction_repo.transactions[7].credit_card_expiration_date
    assert_equal "success", @transaction_repo.transactions[7].result
    assert_equal current_time, @transaction_repo.transactions[7].updated_at.to_s
  end

  def test_it_deletes_transaction_by_id
    assert_instance_of Transaction, @transaction_repo.find_by_id(1)
    @transaction_repo.delete(1)
    assert_equal nil, @transaction_repo.find_by_id(1)
  end

end
