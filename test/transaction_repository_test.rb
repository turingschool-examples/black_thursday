require_relative '../lib/transaction_repository'
require_relative 'spec_helper'
require          'pry'
require          'bigdecimal'
require          'minitest/autorun'
require          'minitest/pride'


class TransactionRepositoryTest < Minitest::Test
  attr_reader :repo


  def test_class_exist
    assert TransactionRepository
  end

  def setup
    @repo = TransactionRepository.new([{:id=>  1, :invoice_id=>  1, :credit_card_number=> BigDecimal.new("4.06863E+15").to_i, :credit_card_expiration_date=> 217, :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
                                       {:id=>  2, :invoice_id=>  2, :credit_card_number=> BigDecimal.new("4.17782E+15").to_i, :credit_card_expiration_date=> 813, :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
                                       {:id=>  3, :invoice_id=>  3, :credit_card_number=> BigDecimal.new("4.27181E+15").to_i, :credit_card_expiration_date=> 1220, :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
                                       {:id=>  4, :invoice_id=>  4, :credit_card_number=> BigDecimal.new("4.04803E+15").to_i, :credit_card_expiration_date=> 313, :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
                                       {:id=>  5, :invoice_id=>  5, :credit_card_number=> BigDecimal.new("4.29722E+15").to_i, :credit_card_expiration_date=> 1215, :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
                                       {:id=>  6, :invoice_id=>  6, :credit_card_number=> BigDecimal.new("4.55837E+15").to_i, :credit_card_expiration_date=> 417, :result=>"success", :created_at=>"2012-02-26 20:56:57 UTC", :updated_at=>"2012-02-26 20:56:57 UTC"},
                                       {:id=>  7, :invoice_id=>  7, :credit_card_number=> BigDecimal.new("4.61325E+15").to_i, :credit_card_expiration_date=> 314, :result=>"success", :created_at=>"2012-02-26 20:56:57 UTC", :updated_at=>"2012-02-26 20:56:57 UTC"},
                                       {:id=>  8, :invoice_id=>  8, :credit_card_number=> BigDecimal.new("4.83951E+15").to_i, :credit_card_expiration_date=> 213, :result=>"success", :created_at=>"2012-02-26 20:56:57 UTC", :updated_at=>"2012-02-26 20:56:57 UTC"},
                                       {:id=>  9, :invoice_id=>  10, :credit_card_number=> BigDecimal.new("4.46353E+15").to_i, :credit_card_expiration_date=> 618, :result=>"failed", :created_at=>"2012-02-26 20:56:57 UTC", :updated_at=>"2012-02-26 20:56:57 UTC"},
                                       {:id=> 10, :invoice_id=>  10, :credit_card_number=> BigDecimal.new("4.14965E+15").to_i, :credit_card_expiration_date=> 420, :result=>"success", :created_at=>"2012-02-26 20:56:57 UTC", :updated_at=>"2012-02-26 20:56:57 UTC"}])
  end

  def test_that_all_is_an_array_with_transaction_instances
    assert_equal Array, repo.all.class
    assert_equal Transaction, repo.all[0].class
  end

  def test_that_find_by_id_works
    assert_equal 217, repo.find_by_id(1).credit_card_expiration_date
  end

  def test_that_find_by_id_method_returns_nil_when_no_matches_found
    assert_equal nil, repo.find_by_id(00000)
  end

  def test_that_find_all_by_invoice_id_works
    assert_equal [9, 10], repo.find_all_by_invoice_id(10).map(&:id)
  end

  def test_that_empty_array_is_returned_when_find_all_by_invoice_id_does_not_find_any_matches
    assert_equal [], repo.find_all_by_invoice_id(0000)
  end

  def test_that_find_by_credit_card_number_works
    assert_equal [1], repo.find_all_by_credit_card_number(4068630000000000).map(&:id)
  end

  def test_that_find_by_credit_card_number_returns_empty_array_when_no_matches_found
    assert_equal [], repo.find_all_by_credit_card_number(00000000)
  end

  def test_find_all_by_result_works
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 10], repo.find_all_by_result("success").map(&:id)
    assert_equal [9], repo.find_all_by_result("failed").map(&:id)
  end

  def test_find_all_by_result_returns_empty_array_when_no_matches_found
    assert_equal [], repo.find_all_by_result("nooo")
  end


end
