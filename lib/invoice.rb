require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repo

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

  def transactions
    @invoice_repo.find_transaction_by_invoice_id(id)
  end

  def customer
    @invoice_repo.find_customer_by_customer_id(customer_id)
  end

  def is_paid_in_full?
    transactions.any? do |transaction|
      transaction.result.downcase == "success"
    end
  end

  def total
    return 0 if is_paid_in_full? == false
    @invoice_repo.find_invoice_item_id(id).map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end.sum
  end

  def total_item_quantities
    return 0 if is_paid_in_full? == false
    @invoice_repo.find_invoice_item_id(id).map do |invoice_item|
      invoice_item.quantity
    end.sum
  end

  def invoice_items
    @invoice_repo.find_item_ids_from_invoice_id(id)
  end

end
