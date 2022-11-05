# frozen_string_literal: true

require 'time'

# Invoice data class, can update status and time updated.
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status

  def initialize(data, repo)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status].to_sym
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @invoice_repo = repo
  end

  def update(attributes)
    @status = attributes[:status]
    @updated_at = Time.now
  end

  def created_at
    return Time.parse(@created_at) if @created_at.is_a? String

    @created_at
  end

  def updated_at
    return Time.parse(@updated_at) if @updated_at.is_a? String

    @updated_at
  end
end
