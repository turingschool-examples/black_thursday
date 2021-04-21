require 'bigdecimal'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :repo

  def initialize(transaction_info, repo)
    @id = transaction_info[:id].to_i
    @invoice_id = transaction_info[:invoice_id]
    @credit_card_number = transaction_info[:credit_card_number].to_s
    @credit_card_expiration_date = transaction_info[:credit_card_expiration_date].to_s
    @result = transaction_info[:result].to_s
    @created_at = Time.parse(transaction_info[:created_at].to_s)
    @updated_at = Time.parse(transaction_info[:updated_at].to_s)
    @repo = repo
  end

  def update_credit_card_number(attributes)
    @credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number]
  end

  def update_all(attributes)
    update_credit_card_number(attributes)
    update_credit_card_expiration_date(attributes)
    update_result(attributes)
    update_updated_at(attributes)
  end

  def update_credit_card_number(attributes)
    @credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number]
  end

  def update_credit_card_expiration_date(attributes)
    @credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date]
  end

  def update_result(attributes)
    @result = attributes[:result] if attributes[:result]
  end

  def update_updated_at(attributes)
    @updated_at = attributes[:updated_at] if attributes[:updated_at]
  end

  def update_id(new_id)
    @id = new_id + 1
  end
end
