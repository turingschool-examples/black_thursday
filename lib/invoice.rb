require 'time'

class Invoice

attr_reader :id,
            :customer_id,
            :merchant_id,
            :status,
            :created_at,
            :updated_at,
            :repository

  def initialize (row, parent)
    @id           = row[:id].to_i
    @customer_id  = row[:customer_id].to_i
    @merchant_id  = row[:merchant_id].to_i
    @status       = row[:status].to_sym
    @created_at   = Time.parse(row[:created_at])
    @updated_at   = Time.parse(row[:updated_at])
    @repository   = parent
  end

  def merchant
    repository.find_merchant(self.merchant_id)
  end

  def items
    repository.find_items_by_invoice_id(self.id)
  end

  def transactions
    repository.find_transactions_by_invoice_id(self.id)
  end

  def customer
    repository.find_customer_by_customer_id(self.customer_id)
  end

end
