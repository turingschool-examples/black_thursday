# transaction class
class Transaction
  attr_reader :id,
              :invoice_id,
              :created_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(transact_hash = Hash.new(0))
    @id = transact_hash[:id].to_i
    @invoice_id = transact_hash[:invoice_id].to_i
    @credit_card_number = transact_hash[:credit_card_number].to_i
    @credit_card_expiration_date = transact_hash[:credit_card_expiration_date]
    @result      = transact_hash[:result]
    @created_at  = transact_hash[:created_at]
    @updated_at  = transact_hash[:updated_at]
  end
end
