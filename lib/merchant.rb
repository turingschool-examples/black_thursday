class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(merchant,repo=nil)
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @created_at = merchant[:created_at]
    @updated_at = merchant[:updated_at]
    @parent = repo
  end

  def items
    parent.merchant_items(self.id)
  end

  def invoices
    parent.merchant_invoices(self.id)
  end
  
  def customers
    parent.merchant_customers(self.id)
  end
end
