require 'csv'
require 'time'


class Transaction

  attr_reader :id, :invoice_id, :engine, :created_at, :updated_at, :credit_card_number, :credit_card_expiration_date, :result

  def initialize(transaction_info, engine)
    @id = transaction_info[:id].to_i
    @credit_card_number = transaction_info[:credit_card_number]
    @invoice_id = transaction_info[:invoice_id].to_i
    @created_at = Time.parse(transaction_info[:created_at])
    @updated_at = Time.parse(transaction_info[:updated_at])
    @credit_card_expiration_date = transaction_info[:credit_card_expiration_date]
    @result = transaction_info[:result]
    @engine = engine
  end

end
