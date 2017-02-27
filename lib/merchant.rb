class Merchant

  attr_reader :id,
              :name,
              :created_at

  attr_accessor :repository

  def initialize (row, repository = nil)
    @id           = row[:id].to_i
    @name         = row[:name]
    @created_at   = row[:created_at]
    @repository   = repository
  end

  def items
    repository.sales_engine.items.find_all_by_merchant_id(self.id)
  end

  def invoices
    repository.sales_engine.invoices.find_all_by_merchant_id(self.id)
  end
end
