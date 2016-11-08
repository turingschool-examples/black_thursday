require 'time'
require 'bigdecimal'

class Transaction
  attr_reader   :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at

  def initialize(transaction_data, parent = nil)
    @transaction_parent          = parent
    @id                          = transaction_data[:id].to_i
    @invoice_id                  = transaction_data[:invoice_id].to_i
    @credit_card_number          = transaction_data[:credit_card_number].to_i
    @credit_card_expiration_date = transaction_data[:credit_card_expiration_date].to_i
    @result                      = transaction_data[:result]
    @created_at                  = determine_the_time(transaction_data[:created_at])
    @updated_at                  = determine_the_time(transaction_data[:updated_at])
  end

  def merchant
    @transaction_parent.parent.merchants.find_by_id(@merchant_id)
  end

  def find_unit_price(price)
    if unit_price == ""
      unit_price = BigDecimal.new(0)
    else
      unit_price = BigDecimal.new(price) / 100
    end
    unit_price
  end

  def unit_price_to_dollars(unit_price)
    @unit_price.to_f
  end

  def determine_the_time(time_string)
    time = Time.new(0)
    return time if time_string == ""
    time_string = Time.parse(time_string)
  end

end