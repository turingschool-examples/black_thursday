require_relative './time_formatter'

class Transaction
  include TimeFormatter
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(trans_data, parent = nil)
    @id                          = trans_data[:id].to_i
    @invoice_id                  = trans_data[:invoice_id].to_i
    @credit_card_number          = trans_data[:credit_card_number].to_i
    @credit_card_expiration_date = trans_data[:credit_card_expiration_date].to_s
    @result                      = trans_data[:result].to_s
    @created_at                  = format_time(trans_data[:created_at].to_s)
    @updated_at                  = format_time(trans_data[:updated_at].to_s)
    @parent                      = parent
  end

  def invoice
    @parent.find_invoice_by_invoice_id(invoice_id)
  end
end
