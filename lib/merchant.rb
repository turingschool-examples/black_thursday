require_relative "../lib/merchant_repo"

class Merchant

  attr_reader :id, :name, :created_at, :updated_at

  def initialize(row, parent = nil)
    @parent = parent
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at].nil?? Time.now : Time.parse(row[:created_at])
    @updated_at = row[:updated_at].nil?? Time.now : Time.parse(row[:updated_at])
  end

  def items
    @parent.find_all_items_by_merchant_id(self.id)
  end

  def invoices
    @parent.find_all_invoices_by_merchant_id(self.id)
  end

  def customers
    @parent.find_all_customers_by_merchant_id(self.id)
  end

end
