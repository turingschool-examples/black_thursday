require 'bigdecimal'

class Transaction
  attr_accessor :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at,
                :repo

  def initialize(transaction_info, repo)
    @id = transaction_info[:id].to_i
    @invoice_id = transaction_info[:invoice_id]
    @credit_card_number = transaction_info[:credit_card_number].to_s
    @credit_card_expiration_date = transaction_info[:credit_card_expiration_date].to_s
    @result = transaction_info[:result].to_s
    @created_at = Time.parse(transaction_info[:created_at].to_s)
    @updated_at = Time.parse(transaction_info[:updated_at].to_s)
    @repo = repo
  end
end
