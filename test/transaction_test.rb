require_relative'test_helper'
require'./lib/transaction'

class TransactionTest < Minitest::Test
	attr_reader :t
	def setup
		@t = Transaction.new({
			:id => 6,
			:invoice_id => 8,
			:credit_card_number => "4242424242424242",
			:credit_card_expiration_date => "0220",
			:result => "success",
			:created_at => Time.now.to_s,
			:updated_at => Time.now.to_s
		}, nil)
	end

	def test_all
		assert_equal 6, t.id
		assert_equal 8, t.invoice_id
		assert_equal 4242424242424242, t.credit_card_number
		assert_equal "0220", t.credit_card_expiration_date
		assert_equal "success", t.result
		assert_instance_of Time, t.created_at
		assert_instance_of Time, t.updated_at
	end
end