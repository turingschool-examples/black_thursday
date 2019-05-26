class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repo

  def initialize(invoice)
    @id           = invoice[:id].to_i
    @customer_id  = invoice[:customer_id].to_i
    @merchant_id  = invoice[:merchant_id].to_i
    @status       = invoice[:status].to_sym
    @created_at   = Time.parse(invoice[:created_at])
    @updated_at   = Time.parse(invoice[:updated_at])
    @invoice_repo = invoice[:invoice_repo]
  end


  def self.creator(row, parent)
    new({
      id: row[:id],
      customer_id: row[:customer_id],
      merchant_id: row[:merchant_id],
      status: row[:status],
      created_at: row[:created_at],
      updated_at: row[:updated_at],
      invoice_repo: parent
    })
  end

  def items
    invoice_items = invoice_repo.items(@id)
    invoice_items.map do |invoice_item|
      invoice_repo.find_item_by_id(invoice_item.item_id)
    end
  end

  def transactions
    invoice_repo.transactions(@id)
  end

  def customer
    invoice_repo.customer(@customer_id)
  end

  def merchant
    invoice_repo.find_merchant_by_invoice(merchant_id)
  end

  def is_paid_in_full?
    transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def total
    invoice_items = invoice_repo.items(@id)
    invoice_items.reduce(0) do |result, invoice_item|
      result += (invoice_item.unit_price * invoice_item.quantity)
    end
  end

end
