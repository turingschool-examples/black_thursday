# frozen_string_literal: true

require 'time'

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
    @status      = params[:status].to_sym
    @created_at  = Time.parse(params[:created_at].to_s)
    @updated_at  = Time.parse(params[:updated_at].to_s)
  end
end
