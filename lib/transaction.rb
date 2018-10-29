require_relative './time_convert_module'

class Transaction

  attr_reader :id,
              :invoice_id,
              :created_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at


  include TimeConvert

  def initialize(transaction_data)
    @id = transaction_data[:id].to_i
    @invoice_id = transaction_data[:invoice_id].to_i
    @credit_card_number = transaction_data[:credit_card_number]
    @credit_card_expiration_date = transaction_data[:credit_card_expiration_date]
    @result = transaction_data[:result].to_sym
    @created_at = time_converter(transaction_data[:created_at])
    @updated_at = time_converter(transaction_data[:updated_at])
  end

end
