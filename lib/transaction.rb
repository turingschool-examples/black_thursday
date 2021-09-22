require 'csv'
require_relative './sales_engine'

class Transaction
  attr_reader   :id,
                :invoice_id,
                :created_at
  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(data)
    @id = data[0].to_i
    @invoice_id = data[1].to_i
    @credit_card_number = data[2].to_s
    @credit_card_expiration_date = data[3]
    @result = data[4].to_sym
    @created_at = Time.parse(data[5])
    @updated_at = Time.parse(data[6])
  end
end
