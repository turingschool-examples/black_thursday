require_relative '../lib/transaction_repository'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class TransactionRepositoryTest < Minitest::Test
  attr_reader :repo


  def test_class_exist
    assert TransactionRepository
  end

  def setup
    @repo = TransactionRepository.new([{:id=>"1", :invoice_id=>"1", :credit_card_number=>"4.06863E+15", :credit_card_expiration_date=>"217", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
                 {:id=>"2", :invoice_id=>"2", :credit_card_number=>"4.17782E+15", :credit_card_expiration_date=>"813", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
                 {:id=>"3", :invoice_id=>"3", :credit_card_number=>"4.27181E+15", :credit_card_expiration_date=>"1220", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
                 {:id=>"4", :invoice_id=>"4", :credit_card_number=>"4.04803E+15", :credit_card_expiration_date=>"313", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
                 {:id=>"5", :invoice_id=>"5", :credit_card_number=>"4.29722E+15", :credit_card_expiration_date=>"1215", :result=>"success", :created_at=>"2012-02-26 20:56:56 UTC", :updated_at=>"2012-02-26 20:56:56 UTC"},
                 {:id=>"6", :invoice_id=>"6", :credit_card_number=>"4.55837E+15", :credit_card_expiration_date=>"417", :result=>"success", :created_at=>"2012-02-26 20:56:57 UTC", :updated_at=>"2012-02-26 20:56:57 UTC"},
                 {:id=>"7", :invoice_id=>"7", :credit_card_number=>"4.61325E+15", :credit_card_expiration_date=>"314", :result=>"success", :created_at=>"2012-02-26 20:56:57 UTC", :updated_at=>"2012-02-26 20:56:57 UTC"},
                 {:id=>"8", :invoice_id=>"8", :credit_card_number=>"4.83951E+15", :credit_card_expiration_date=>"213", :result=>"success", :created_at=>"2012-02-26 20:56:57 UTC", :updated_at=>"2012-02-26 20:56:57 UTC"},
                 {:id=>"9", :invoice_id=>"9", :credit_card_number=>"4.46353E+15", :credit_card_expiration_date=>"618", :result=>"failed", :created_at=>"2012-02-26 20:56:57 UTC", :updated_at=>"2012-02-26 20:56:57 UTC"},
                 {:id=>"10", :invoice_id=>"10", :credit_card_number=>"4.14965E+15", :credit_card_expiration_date=>"420", :result=>"success", :created_at=>"2012-02-26 20:56:57 UTC", :updated_at=>"2012-02-26 20:56:57 UTC"}])
  end

  def test_that_all_is_an_array_with_transaction_instances
    assert_equal Array, repo.all.class
    assert_equal Transaction, repo.all[0].class
  end





end
