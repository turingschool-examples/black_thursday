# frozen_string_literal: true

# Invoice class
class Invoice
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :created_at

  attr_accessor :status,
                :updated_at

  def initialize(params)
    @id          = params[:id].to_i
    @customer_id = params[:customer_id].to_i
    @merchant_id = params[:merchant_id].to_i
    @status      = params[:status]
    @created_at  = params[:created_at]
    @updated_at  = params[:updated_at]
  end
end
