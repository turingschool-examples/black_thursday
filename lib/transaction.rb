require 'time'

class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(transaction_info, transaction_repo)
    @id = transaction_info[:id].to_i
    @invoice_id = transaction_info[:invoice_id].to_i
    @credit_card_number = transaction_info[:credit_card_number].to_i
    @credit_card_expiration_date = transaction_info[:credit_card_expiration_date]
    @result = transaction_info[:result]
    @created_at = Time.parse(transaction_info[:created_at])
    @updated_at = Time.parse(transaction_info[:updated_at])
  end

end
