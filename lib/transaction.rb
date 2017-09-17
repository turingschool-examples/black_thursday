require 'time'
require 'bigdecimal'
require 'csv'

class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :parent


  def initialize(data, repo = nil)
    @id                           = data[:id].to_i
    @invoice_id                   = data[:invoice_id].to_i
    @credit_card_number           = data[:credit_card_number].to_i
    @credit_card_expiration_date  = data[:credit_card_expiration_date].to_s
    @result                       = data[:result]
    @created_at                   = Time.parse(data[:created_at])
    @updated_at                   = Time.parse(data[:updated_at])
    @parent                       = repo
  end
end
