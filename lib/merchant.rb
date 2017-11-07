class Merchant
  attr_reader :id,
              :name,
              :repository

  def initialize(row, parent)
    @id   = row[:id]
    @name = row[:name]
    @repository = parent
  end

  def items
    repository.find_items(self.id)
  end

  def invoices
    repository.find_invoices_by_merchant_id(self.id)
  end

  def customers
     invoices.map do |invoice|
       repository.find_customer_by_customer_id(invoice.customer_id)
     end
  end

end
