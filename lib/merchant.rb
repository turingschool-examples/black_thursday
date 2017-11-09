class Merchant
  attr_reader :id,
              :name,
              :repository,
              :updated_at,
              :created_at

  def initialize(row, parent)
    @id         = row[:id].to_i
    @name       = row[:name]
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @repository = parent
  end

  def items
    repository.find_items(self.id)
  end

  def invoices
    repository.find_invoices_by_merchant_id(self.id)
  end

  def invoice_items
    invoices.invoice_items
  end

  def customers
     invoices.map do |invoice|
       repository.find_customer_by_customer_id(invoice.customer_id)
     end.uniq
  end

  def valid_invoices
    invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end

end
