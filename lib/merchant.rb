class Merchant
  attr_accessor :id, :name, :repo
  def initialize(attributes, repo = nil)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @repo = repo
  end

  def items
    @repo.find_all_items_by_merchant_id(id)
  end

  def invoices
    @repo.find_all_invoices_by_merchant_id(id)
  end

  def invoice_total(invoice_id)
    @repo.invoice_total(invoice_id)
  end

  def total_revenue 
    invoices.map do |invoice|
      invoice_total(invoice.id)
    end.compact.sum
  end
end
