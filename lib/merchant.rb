class Merchant
  attr_reader :id,
              :name

  def initialize(data, parent)
    @id = data[:id]
    @name = data[:name]
    @merchant_repository = parent
  end

  def items
    @merchant_repository.find_items_by_id(@id)
  end

  def item_count
    return items.count
  end
end
