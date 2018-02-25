# Merchant class
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
    @parent.items(@id)
  end

  def invoices
    @parent.invoices(@id)
  end

  def customers
    @parent.customers(@id)
  end
end
