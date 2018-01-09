require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  def setup
    @tr = mock('transactionrepository')
    @t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now.inspect,
      :updated_at => Time.now.inspect
    }, @tr)
  end

  def test_it_has_an_id
    assert_equal 6, @t.id
  end

  def test_it_has_an_invoice_id
    assert_equal 8, @t.invoice_id
  end

  def test_it_has_a_credit_card_number
    assert_equal 4242424242424242, @t.credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date
    assert_equal "0220", @t.credit_card_expiration_date
  end

  def test_it_has_a_result
    assert_equal "success", @t.result
  end

  def test_it_has_a_time_created_at
    assert_equal Time.now.inspect, @t.created_at.inspect
  end

  def test_it_has_a_time_updated_at
    assert_equal Time.now.inspect, @t.updated_at.inspect
  end

  def test_it_calls_its_parent_to_find_its_invoice
    invoice = mock('invoice')
    @tr.expects(:find_invoice_by_invoice_id).returns(invoice)

    assert_equal invoice, @t.invoice
  end
end
