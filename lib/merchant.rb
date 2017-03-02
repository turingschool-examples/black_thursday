require_relative "../lib/item_data_access"
class Merchant
  attr_reader :id,
              :name,
              :parent,
              :created_at

  def initialize(data, parent=nil)
    @id  = data[:id]
    @name = data[:name]
    @parent = parent
    @created_at = data[:created_at]
  end

  def items
    parent.parent.items.find_all_by_merchant_id(id)
  end

  def customers
    parent.parent.invoices.find_all_by_merchant_id(id).map {|i| i.customer}.uniq
  end

  def invoices
    parent.parent.invoices.find_all_by_merchant_id(@id)
  end
end
