class Merchant
  attr_reader :id, :name, :created_at

  def initialize(item, parent=nil)
    @id         = item[:id].to_i
    @name       = item[:name]
    @created_at = Time.parse(item[:created_at].to_s)
    @parent     = parent
  end

  def items
    @parent.find_all_by_merchant_id(id)
  end

  def invoices
    @parent.find_invoices_by_merchant_id(id)
  end

  def customers
    @parent.find_all_customers_per_merchant(id)
  end
end
