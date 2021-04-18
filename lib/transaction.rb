require 'bigdecimal'
require 'time'

class Transaction
  attr_reader   :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at

  def initialize(row, transaction_repo)
    @id = (row[:id]).to_i
    @invoice_id = row[:invoice_id].to_i
    @credit_card_number = (row[:credit_card_number])
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result = row[:result].to_sym
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @transaction_repo = transaction_repo
  end

  def update(attributes)
    update_credit_card_expiration_date(attributes)
    update_credit_card_number(attributes)
    update_result(attributes)
    update_time_stamp
  end

  def update_credit_card_number(attributes)
    return nil if attributes[:credit_card_number] == nil
        @credit_card_number = attributes[:credit_card_number]
  end

  def update_credit_card_expiration_date(attributes)
    return nil if attributes[:credit_card_expiration_date] == nil
    @credit_card_expiration_date = attributes[:credit_card_expiration_date]
  end

  def update_result(attributes)
    return nil if attributes[:result] == nil
    @result = attributes[:result].to_sym
  end

  def update_time_stamp
    @updated_at = Time.now
  end
end
