require 'bigdecimal'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(attributes)
    @id         = attributes[:id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @credit_card_number = attributes[:credit_card_number].to_s
    @credit_card_expiration_date = attributes[:credit_card_expiration_date].to_s
    @result = attributes[:result].to_sym
    @created_at = Time.parse(attributes[:created_at].to_s)
    @updated_at = Time.parse(attributes[:updated_at].to_s)
  end

  def update_result(attributes)
    @result = attributes[:result].to_sym
  end

  def update_credit_card_number(attributes)
    @credit_card_number = attributes[:credit_card_number].to_s
  end

  def update_credit_card_expiration_date(attributes)
    @credit_card_expiration_date = attributes[:credit_card_expiration_date].to_s
  end

  def update_updated_at(attributes)
    @updated_at = attributes
  end
end
