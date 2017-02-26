class Merchant
  attr_reader :merchant_hash, :repository

  def initialize(hash, repository)
    @merchant_hash = hash
    @repository = repository
  end

  def id
    merchant_hash[:id]
  end

  def name
    merchant_hash[:name]
  end

  def items
    repository.engine.items.find_all_by_merchant_id(id)
  end

  def invoices
    repository.engine.invoices.find_all_by_merchant_id(id)
  end

  def customers
    invoices.map do |invoice|
      invoice.customer
    end
  end
end

# m = Merchant.new({:id => 5, :name => "Turing School"})
