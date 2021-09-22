# frozen_string_literal:true

# This is an Invoice class for Black Friday

require 'Date'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(new_invoice)
    @id = new_invoice[:id].to_i
    @customer_id = new_invoice[:customer_id].to_i
    @merchant_id = new_invoice[:merchant_id].to_i
    @status = new_invoice[:status].to_sym
    @created_at = Time.parse(new_invoice[:created_at])
    @updated_at = Time.parse(new_invoice[:updated_at])
  end

  # look at edge cases for attr input
  def update(key, value)
    @status = value if key == :status
    @updated_at = Time.now
  end
end
