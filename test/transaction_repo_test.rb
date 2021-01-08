require 'CSV'
require './test/test_helper'

class TransactionRepoTest < Minitest::Test

  def setup
    @engine = mock
    @dummy_repo = TransactionRepo.new("./dummy_data/dummy_transactions.csv", @engine)
  end

  def test_it_is
    assert_instance_of TransactionRepo, @dummy_repo
  end

  def test_it_has_attributes
    assert_instance_of Hash , @dummy_repo.collections
  end

  def test_find_by_id
    actual = @dummy_repo.find_by_id("1")
    assert_equal "2179", actual.invoice_id
  end

  def test_find_all_by_invoice_id
    actual = @dummy_repo.find_all_by_invoice_id("2179")
    assert_equal "4068631943231473", actual[0].credit_card_number
  end

  def test_find_all_by_credit_card_number
    actual = @dummy_repo.test_find_all_by_credit_card_number("4558368405929183")
    assert_equal "4966", actual[0].invoice_id
  end

  def test_find_all_by_result
    actual = @dummy_repo.find_all_by_result("failed")
    assert_equal "4463525332822998", actual[0].credit_card_number
  end

  def test_it_can_create_new_item
    data = {
      :id => "20",
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now  }
    @dummy_repo.create(data)
    actual = @dummy_repo.find_by_id("10")
    assert_equal "success", actual.result
  end

  def test_update
    actual = @dummy_repo.find_by_id("9")
    assert_equal "failed", actual.result
    actual = @dummy_repo.find_all_by_invoice_id("1752")
    assert_equal "4463525332822998", actual[0].credit_card_number

    @dummy_repo.update({id: "9",
                        credit_card_number: "1234567891011", credit_card_expiration_date: "0221", status: "success"})

    actual = @dummy_repo.find_by_id("9")
    assert_equal "0221", actual.credit_card_expiration_date
  end

  def test_delete
    data = {
      :id => "20",
      :invoice_id => "8",
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now  }
    @dummy_repo.create(data)
    actual = @dummy_repo.find_all_by_invoice_id("8")
    assert_equal "10", actual[0].id
    @dummy_repo.delete("10")

    assert_nil nil, @dummy_repo.find_by_id("10")
  end

end
