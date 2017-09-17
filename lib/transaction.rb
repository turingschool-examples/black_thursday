require 'time'

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :result
  def initialize(info, transaction_repo)
    @id = info[:id].to_i
    @invoice_id = info[:invoice_id].to_i
    @credit_card_number = info[:credit_card_number].to_i
    @credit_card_expiration_date = info[:credit_card_expiration_date]
    @result = info[:result].to_sym
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @transaction_repo = transaction_repo
  end
end
