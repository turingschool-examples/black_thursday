require './test/test_helper'
require './lib/transaction_repository'
require './lib/file_loader'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @mock_data = [
     {:id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0418",
      :result => "failed",
      :created_at => Time.now,
      :updated_at => Time.now},
     {:id => 7,
      :invoice_id => 8,
      :credit_card_number => "3737373737373737",
      :credit_card_expiration_date => "0220",
      :result => :success,
      :created_at => Time.now,
      :updated_at => Time.now},
     {:id => 8,
      :invoice_id => 9,
      :credit_card_number => "3737373737373737",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now},
     {:id => 9,
      :invoice_id => 10,
      :credit_card_number => "5959595959595959",
      :credit_card_expiration_date => "1219",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now}
      ]

      @transaction_repo = TransactionRepository.new(@mock_data)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transaction_repo
  end

  def test_it_can_find_all_transactions
    assert_equal 4, @transaction_repo.all.count
  end

  def test_it_can_find_a_transaction_by_id
    assert_equal @transaction_repo.all[-1], @transaction_repo.find_by_id(9)
  end

  def test_it_can_find_transactions_by_invoice_id
    result = [@transaction_repo.all[0], @transaction_repo.all[1]]
    assert_equal result, @transaction_repo.find_all_by_invoice_id(8)
  end

  def test_it_can_find_all_by_credit_card_number
    card_number = "3737373737373737"
    result = [@transaction_repo.all[1], @transaction_repo.all[2]]
    actual = @transaction_repo.find_all_by_credit_card_number(card_number)
    assert_equal result, actual
  end

  def test_it_can_find_all_transactions_by_credit_card_result
    result = [@transaction_repo.all[0]]
    assert_equal result, @transaction_repo.find_all_by_result(:failed)
  end

  def test_it_can_create_a_new_transaction
    @transaction_repo.create(
    {:invoice_id => 10,
     :credit_card_number => "5959595959595959",
     :credit_card_expiration_date => "1219",
     :result => "success",
     :created_at => Time.now,
     :updated_at => Time.now}
   )

   assert_equal 10, @transaction_repo.all[-1].id
   assert_equal "5959595959595959", @transaction_repo.all[-1].credit_card_number
   assert_equal "1219", @transaction_repo.all[-1].credit_card_expiration_date
   assert_equal :success, @transaction_repo.all[-1].result
  end

  def test_it_can_update_all_transaction_attributes
    attributes = {:credit_card_number => "121212121212",
      :credit_card_expiration_date => "1118",
      :result => "failed"}
    @transaction_repo.update(6, attributes)

    assert_equal "121212121212", @transaction_repo.all[0].credit_card_number
    assert_equal "1118", @transaction_repo.all[0].credit_card_expiration_date
    assert_equal "failed", @transaction_repo.all[0].result
  end

  def test_it_can_update_one_transaction_attribute
    @transaction_repo.update(6, {:result => "success"})

    assert_equal "4242424242424242", @transaction_repo.all[0].credit_card_number
    assert_equal "0418", @transaction_repo.all[0].credit_card_expiration_date
    assert_equal "success", @transaction_repo.all[0].result
  end

  def test_it_can_delete_a_transaction
    @transaction_repo.delete(9)

    assert_equal 3, @transaction_repo.all.count
    assert_equal 8, @transaction_repo.all[-1].id
  end
end
