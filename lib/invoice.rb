require 'pry'

class Invoice
  attr_reader :invoice_attributes

  def initialize(attributes)
    @invoice_attributes = attributes
    @invoice_attributes[:id] = invoice_attributes[:id].to_i
    @invoice_attributes[:customer_id] = invoice_attributes[:customer_id].to_i
    @invoice_attributes[:merchant_id] = invoice_attributes[:merchant_id].to_i
    @invoice_attributes[:status] = invoice_attributes[:status].to_sym
  end
end
