require_relative 'element'

# This class defines invoices
class Invoice
  include Element

  def initialize(attributes, engine = nil)
    @attributes = attributes
    @engine = engine
  end

  def customer_id
    @attributes[:customer_id].to_i
  end

  def status
    @attributes[:status].to_sym
  end

  def is_paid_in_full?
    transactions = @engine.transactions.find_all_by_invoice_id(id)
    transactions.any? do |transaction|
      transaction.result == 'success'
    end
  end

  def total
    invoice_items = @engine.invoice_items.find_all_by_invoice_id(id)
    total = 0
    invoice_items.each do |invoice_item|
      total += invoice_item.unit_price * invoice_item.quantity
    end
    total
  end

  def customer
    @engine.customers.find_by_id(customer_id)
  end

  def update(states)
    super(states)
    attributes[:status] = states[:status] if states[:status]
  end
end
