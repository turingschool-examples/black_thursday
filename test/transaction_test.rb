require './test/test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    @transaction = {
      :id                          => 6,
      :invoice_id                  => 8,
      :credit_card_number          => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result                      => "success",
      :created_at                  => Time.now,
      :updated_at                  => Time.now
    }
  end

  def test_it_has_an_id
    assert_equal 602397854, @merchant.id
  end

  def test_it_has_a_name
    assert_equal "Burger King", @merchant.name
  end

  def test_it_has_a_created_at
    assert_equal Time, @merchant.created_at.class
  end

  def test_it_has_a_updated_at
    assert_equal Time, @merchant.updated_at.class
  end
end
