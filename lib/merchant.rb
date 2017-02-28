class Merchant
  attr_reader :id, :name, :repo

  def initialize(row, repo)
    @id = row[:id].to_i
    @name = row[:name]
    @repo = repo
  end

  def items
    repo.sales_engine.items.find_all_by_merchant_id(self.id)
  end

  def invoices
    repo.sales_engine.invoices.find_all_by_merchant_id(self.id)
  end

  def customers
    uniq_customers = []
    invoices.each do | invoice|
      unless uniq_customers.include?(invoice.customer)
        uniq_customers << invoice.customer
      end
    end
    uniq_customers
  end

  def revenue
    invoices.map { |invoice| invoice.total }.reduce(:+)
  end

  def has_pending_invoices?
    !invoices.all? { |invoice| invoice.is_paid_in_full? }
  end
end
