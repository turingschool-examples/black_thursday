class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(attributes, parent = nil)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @parent = parent
  end

  def items
    self.parent.parent.items.find_all_by_merchant_id(self.id)
  end

  def invoices
    parent.parent.invoices.find_all_by_merchant_id(self.id)
  end

end
