require 'time'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repo

  def initialize(invoice_info, invoice_repo)
    @id =             invoice_info[:id].to_i
    @customer_id =    invoice_info[:customer_id].to_i
    @merchant_id =    invoice_info[:merchant_id].to_i
    @status =         invoice_info[:status].to_sym
    @created_at =     Time.parse(invoice_info[:created_at])
    @updated_at =     Time.parse(invoice_info[:updated_at])
    @invoice_repo =   invoice_repo
  end

  def merchant
    self.invoice_repo.invoice_repo_to_se_merchant(merchant_id)
  end

  def items
    self.invoice_repo.invoice_repo_to_se_items(id)
  end

  def transactions
    self.invoice_repo.invoice_repo_to_se_transactions(id)
  end

  def customer
    self.invoice_repo.invoice_repo_to_se_customer(customer_id)
  end

  def invoice_items
    self.invoice_repo.invoice_repo_to_se_invoice_items(id)
  end

  def is_paid_in_full?
    transactions = self.transactions
    return false if transactions.empty?
    transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def total
    return 0 if !self.is_paid_in_full?
    self.invoice_items.inject(0) do |sum, invoice_item_instance|
      sum += invoice_item_instance.quantity * invoice_item_instance.unit_price
    end
  end

end
