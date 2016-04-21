class Merchant
  attr_reader :id, :name, :merchant_repo

  def initialize(line_of_merchant, parent)
    @id = line_of_merchant.fetch(:id).to_i
    @name = line_of_merchant.fetch(:name)
    @merchant_repo = parent
  end

  def items
    merchant_repo.find_items_by_merchant_id(id)
  end

end
