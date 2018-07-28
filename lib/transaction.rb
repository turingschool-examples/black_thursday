# frozen_string_literal: true

# Transaction class
class Transaction
  attr_reader   :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :created_at
  attr_accessor :result,
                :updated_at

  def initialize(params)
    @id                          = params[:id].to_i
    @invoice_id                  = params[:invoice_id].to_i
    @credit_card_number          = params[:credit_card_number]
    @credit_card_expiration_date = params[:credit_card_expiration_date]
    @result                      = params[:result]
    @created_at                  = params[:created_at]
    @updated_at                  = params[:updated_at]
  end
end
