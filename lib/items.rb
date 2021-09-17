class Items
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :merchant_id,
                :created_at,
                :updated_at

  def initialize(items)
    @id = items[:id].to_i
    @name = items[:name]
    @description = items[:description]
    @unit_price = items[:unit_price].to_i
    @merchant_id = items[:merchant_id]
    @created_at = items[:created_at]
    @updated_at = items[:updated_at]
  end

  def item_repo
    ItemRepository.new(@items)
  end
end
