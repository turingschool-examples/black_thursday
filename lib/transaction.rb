# frozen_string_literal: true

# Transaction class, built for the Black Thursday project!

class Transaction
  attr_reader :id,
              :invoice_id,
              :cc_num,
              :cc_exp,
              :result,
              :created_at,
              :updated_at

  def initialize(transaction)
    @id = transaction[:id].to_i
    @invoice_id = transaction[:invoice_id]
    @cc_num = transaction[:cc_num]
    @cc_exp = transaction[:cc_exp]
    @result = transaction[:result]
    @created_at = transaction[:created_at]
    @updated_at = transaction[:updated_at]
  end

  def update(attributes)
    @last_updated = Time.now
    @cc_num = attributes[:cc_num] unless attributes[:cc_num].nil?
    @cc_exp = attributes[:cc_exp] unless attributes[:cc_exp].nil?
    @result = attributes[:result] unless attributes[:result].nil?
    self
  end
end
