require 'pry'

class Merchant
  attr_reader   :name, :id
  attr_accessor :items, :invoices, :customers

  def initialize(merchant_info)
    @name       = merchant_info[:name]
    @id         = merchant_info[:id].to_i
  end

  def total_revenue
    invoices.reduce(0.0) do |sum , invoice|
      if invoice.total == nil
        sum + 0
      else
        sum + invoice.total
      end
    end
  end

  def invoice_status_pending
    invoices.any? do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def merchant_with_one_item
    items.count == 1
  end

end
