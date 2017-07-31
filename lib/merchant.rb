class Merchant

  attr_reader :id,
              :name,
              :parent

  def initialize(hash, repo=nil)
    @id     = hash[:id].to_i
    @name   = hash[:name]
    @parent = repo
  end

  def items
    parent.items_of_merchant(id)
  end

  def invoices
    parent.invoices_of_merchant(id)
  end

  def customers
    parent.customers_of_merchant(id)
  end

end
