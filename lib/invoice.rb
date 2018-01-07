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
    invoice_repo.items(@merchant_id)
  end

  def transactions
    invoice_repo.transactions(@id)
  end

  def merchant
    invoice_repo.find_merchant_by_invoice(merchant_id)
  end

end
