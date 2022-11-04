# frozen_string_literal: true

# Invoice data class, can update status and time updated.
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, repo)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status      = data[:status]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @invoice_repo = repo
  end

  def update(attributes)
    @status = attributes[:status]
    @updated_at = Time.now
  end
end
