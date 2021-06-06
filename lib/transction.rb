require 'CSV'
require 'time'
class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(transaction_data, repo)
    @id = transaction_data[:id].to_i
    @invoice_id = transaction_data[:invoice_id]
    @credit_card_number = transaction_data[:credit_card_number].to_s
    @credit_card_expiration_date = transaction_data[:credit_card_expiration_date].to_s
    @result = transaction_data[:result].to_s
    @created_at = Time.parse(transaction_data[:created_at].to_s)
    @updated_at = Time.parse(transaction_data[:updated_at].to_s)
    @repo = repo
  end

  def update_time
    @updated_at = Time.now
  end
end
