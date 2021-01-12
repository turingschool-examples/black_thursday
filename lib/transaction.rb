require_relative './time_store_module'

class Transaction
  include TimeStoreable

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  attr_reader   :id,
                :invoice_id,
                :created_at

  def initialize(data, repository)
    @id                           = data[:id].to_i
    @invoice_id                   = data[:invoice_id]
    @credit_card_number           = data[:credit_card_number]
    @credit_card_expiration_date  = data[:credit_card_expiration_date]
    @result                       = :"#{data[:result]}"
    @created_at                   = time_store(data[:created_at])
    @updated_at                   = time_store(data[:updated_at])
    @repository                   = repository
  end
end
