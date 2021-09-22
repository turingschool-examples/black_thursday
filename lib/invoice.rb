# frozen_string_literal: true
class Invoice
  attr_reader :id,
              :created_at,
              :updated_at,
              :merchant_id,
              :customer_id,
              :status

  def initialize(info)
    @id            = info[:id].to_i
    @customer_id   = info[:customer_id].to_i
    @merchant_id   = info[:merchant_id].to_i
    @status        = info[:status].to_sym
    @created_at    = Time.parse(info[:created_at])
    @updated_at    = Time.parse(info[:updated_at])
  end

  def change_status(new_status)
    @status = new_status
    @updated_at = Time.now.utc
  end
end
