class Merchant

  attr_reader :id, 
              :name, 
              :parent

  def initialize(data, parent)
    @id     = data[:id].to_i
    @name   = data[:name]
    @parent = parent
  end

  def items
    parent.find_items_by_merchant_id(id)
  end

  def invoices
    parent.find_invoices_by_merchant_id(id)
  end

end