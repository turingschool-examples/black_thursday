require_relative './time_formatter'
require 'bigdecimal'

class Invoice
  include TimeFormatter
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(invoice_data, parent = nil)
    @id          = invoice_data[:id].to_i
    @customer_id = invoice_data[:customer_id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @status      = invoice_data[:status].to_sym
    @created_at  = format_time(invoice_data[:created_at].to_s)
    @updated_at  = format_time(invoice_data[:updated_at].to_s)
    @parent      = parent
  end

  def merchant
    @parent.find_merchant_by_merchant_id(merchant_id)
  end
end
