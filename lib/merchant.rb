require_relative "../lib/merchant_repo"

class Merchant

  attr_reader :id, :name, :created_at, :updated_at

  def initialize(row, parent = nil)
    @parent = parent
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = Time.strptime(row[:created_at], "%Y-%m-%d")
    @updated_at = Time.strptime(row[:updated_at], "%Y-%m-%d")
  end

  def items
    @parent.find_items_by_merchant_id(self.id)
  end

  def invoices
    @parent.find_invoices_by_merchant_id(self.id)
  end

end
