require 'pry'

class Merchant
  attr_reader   :name, :id, :created_at
  attr_accessor :items, :invoices, :customers

  def initialize(merchant_info)
    @name       = merchant_info[:name]
    @id         = merchant_info[:id].to_i
    @created_at = Time.parse(merchant_info[:created_at])
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
    invoices.find do |invoice|
      invoice.invoice_with_pending_transactions == nil
    end
  end

  def merchant_with_one_item
    items.count == 1
  end

  # def most_sold_items
  #   invoices.map do |invoice|
  #     binding.pry
  #     invoice.item_price_quantity
  #   end
  # end



end
