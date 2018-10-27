require './test/test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test
  def setup
    @tr = Transaction.new({:id => 12,
      :invoice_id => 3345,
      :credit_card_number => 4068631943231473,
      :credit_card_expiration => 0217,
      :result => "success",
      :created_at => Time.parse("2012-02-26 20:56:56 UTC"),
      :updated_at=> Time.parse("2012-02-26 20:56:56 UTC")})
  end

  def test_it_exists
    assert_instance_of Transaction, @tr
  end

end
