# Merchant
class Merchant
  attr_reader :id,
              :name,
              :parent

  def initialize(merchant, parent)
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @parent = parent
  end

  def items
    parent.collect_id_for_items(id)
  end

  def invoices
    parent.collect_id_for_invoices(id)
  end
end
