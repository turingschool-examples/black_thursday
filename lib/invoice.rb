require 'bigdecimal'
require 'time'

class Invoice
  attr_reader :id,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :parent,
              :status,
              :customer_id

  def initialize(invoice_info = nil, repo = nil)
    return if invoice_info.to_h.empty?
    @parent      = repo
    @id          = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id].to_i
    @status      = invoice_info[:status].to_s
    @created_at  = Time.parse(invoice_info[:created_at].to_s)
    @updated_at  = Time.parse(invoice_info[:updated_at].to_s)
    @merchant_id = invoice_info[:merchant_id].to_i
  end

  def invoice
    parent.find_invoice_for_id(@merchant_id)
  end

end
