class Merchant

  attr_reader :id,
              :name,
              :created_at

  attr_accessor :repository

  def initialize (row, repository = nil)
    @id           = row[:id].to_i
    @name         = row[:name]
    @created_at   = Time.parse(row[:created_at])
    @repository   = repository
  end

  def items
    repository.sales_engine.items.find_all_by_merchant_id(self.id)
  end

  def invoices
    repository.sales_engine.invoices.find_all_by_merchant_id(self.id)
  end

  def customers
    self.invoices.map { |pizza| pizza.customer }.uniq
  end

  def invoice_total
    invoices.reduce(0) { |sum, invoice| sum + invoice.total }
  end

  def invoices_paid_in_full
    invoices.select { |row| row.is_paid_in_full? }
  end

  def paid_in_full_total
    all_invoices = invoices
    paid_invoces = all_invoices.select { |invoice| return 0.0 unless invoice.is_paid_in_full? }
    paid_invoces.reduce(0) do |sum, invoice|
      sum + invoice.total
    end
  end

  def merchants_with_only_one_item
    items.sort
  end

end
