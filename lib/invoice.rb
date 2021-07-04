require 'time'

class Invoice
  attr_reader     :id,
                  :customer_id,
                  :merchant_id,
                  :status,
                  :created_at,
                  :updated_at

  def initialize(attributes = {}, parent = nil)
    @id           = attributes[:id].to_i
    @customer_id  = attributes[:customer_id].to_i
    @merchant_id  = attributes[:merchant_id].to_i
    @status       = attributes[:status].to_sym
    @created_at   = Time.parse(attributes[:created_at])
    @updated_at   = Time.parse(attributes[:updated_at])
    @invoice_repo = parent
  end

  def merchant
    @invoice_repo.find_merchant_for_invoice(merchant_id)
  end

end
