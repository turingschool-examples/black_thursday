require 'time'
require 'pry'

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

  def items
    @invoice_repo.find_item_ids_from_invoice_id(id).map do |invoice_item|
      @invoice_repo.find_all_items_by_item_id(invoice_item.item_id)
    end
  end

end
