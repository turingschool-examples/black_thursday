# frozen_string_literal: true

# Defines an Invoice
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, repository)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_sym
    @created_at = Time.parse data[:created_at]
    @updated_at = Time.parse data[:updated_at]

    @invoice_repository = repository
  end

  def merchant
    @invoice_repository.merchant @merchant_id
  end
end
