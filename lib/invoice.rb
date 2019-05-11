# frozen_string_literal: true

# invoice
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repository

  def initialize(data, parent)
    @id                 = data[:id].to_i
    @customer_id        = data[:customer_id].to_i
    @merchant_id        = data[:merchant_id].to_i
    @status             = data[:status].to_sym
    @created_at         = Time.parse(data[:created_at])
    @updated_at         = Time.parse(data[:updated_at])
    @invoice_repository = parent
  end

  def change_shipping_status(shipping_status)
    @status = shipping_status.to_sym
  end

  def change_updated_at
    @updated_at = Time.now
  end
end
