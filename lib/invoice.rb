# frozen_string_literal: true

# creates invoices
class Invoice
  attr_reader   :customer_id,
                :merchant_id,
                :parent
  attr_accessor :created_at,
                :updated_at,
                :status,
                :id

  def initialize(data, _parent)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_sym
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
  end
end
