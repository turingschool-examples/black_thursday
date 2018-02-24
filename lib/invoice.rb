require 'time'
require 'pry'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repo

  def initialize(data, parent = nil)
    @id             = data[:id].to_i
    @customer_id    = data[:customer_id].to_i
    @merchant_id    = data[:merchant_id].to_i
    @status         = data[:status].to_sym
    @created_at     = Time.parse(data[:created_at])
    @updated_at     = Time.parse(data[:updated_at])
    @invoice_repo   = parent
  end

  def merchant
    invoice_repo.find_merchant_by_merchant_id(merchant_id)
  end

  def find_invoice_items_by_invoice_id
    invoice_items = invoice_repo.find_invoice_items_by_invoice_id(id)
    invoice_items.find_all do |invoice_item|
      invoice_repo.find_item_by_id(invoice_item.item_id)
    end
  end

  def items
    find_invoice_items_by_invoice_id.map do |invoice_item|
      invoice_repo.find_item_by_id(invoice_item.item_id)
    end
  end

end
