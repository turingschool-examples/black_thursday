class Merchant
  attr_reader :id, :name, :merchant_repo

  def initialize(line_of_data, parent = nil)
    @id = line_of_data[:id].to_i
    @name = line_of_data[:name]
    @merchant_repo = parent
  end

  def items
    merchant_repo.find_items_by_merchant_id(id)
  end

  def invoices
    merchant_repo.find_invoices_by_merchant_id(id)
  end

end
