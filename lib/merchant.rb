require 'bigdecimal'

class Merchant
  attr_reader :id,
              :name

  def initialize(data, parent)
    @id = data[:id]
    @name = data[:name]
    @merchant_repository = parent
  end

  def items
    @merchant_repository.find_items_by_id(@id)
  end

  def average_item_price
    sum_prices = items.reduce(0) do |total, item|
      total + item.unit_price
    end
    return (sum_prices / items.count).round(2)
  end

  def invoices
    @merchant_repository.find_invoices_by_id(@id)
  end

  def customers
    invoices.map do |invoice|
      invoice.customer
    end.uniq
  end

  def paid_invoices
    invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def revenue
    paid_invoices.sum do |invoice|
      invoice.total
    end
  end

  def pending_invoices?
    invoices.any? do |invoice|
      invoice.status == :pending
    end
  end  
end
