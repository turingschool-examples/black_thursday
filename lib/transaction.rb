require_relative '../lib/modules/timeable'

class Transaction
  include Timeable

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(data)
    @id                          = data[:id].to_i
    @invoice_id                  = data[:invoice_id].to_i
    @credit_card_number          = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result                      = data[:result].to_sym
    @created_at                  = update_time(data[:created_at].to_s)
    @updated_at                  = update_time(data[:updated_at].to_s)
  end

  def update(attributes)
    @credit_card_number          = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
    @credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
    @result                      = attributes[:result].to_sym unless attributes[:result].nil?
    @updated_at                  = update_time('')
  end
end
