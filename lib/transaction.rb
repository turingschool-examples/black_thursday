require 'time'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result].to_sym
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
  end

  def update_credit_card_number(card_num)
    @credit_card_number = card_num
  end

  def update_credit_card_expiration(card_exp)
    @credit_card_expiration_date = card_exp
  end

  def update_result(result)
    @result = result
  end

  def new_update_time(new_time)
    @updated_at = new_time
  end
end
