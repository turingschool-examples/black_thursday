class Merchant

  attr_reader :id,
              :name,
              :merchant_repo

  def initialize(data, parent = nil)
    @id              = data[:id].to_i
    @name            = data[:name]
    @merchant_repo   = parent
  end

  def items
    merchant_repo.find_items_by_merchant_id(id)
  end

end
