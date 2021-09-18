class Items
  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at
  attr_reader :id,
              :merchant_id,
              :created_at

  def initialize(items)
    @id = items[:id].to_i
    @name = items[:name]
    @description = items[:description]
    @unit_price = items[:unit_price].to_f / 100
    @merchant_id = items[:merchant_id].to_i
    @created_at = items[:created_at]
    @updated_at = items[:updated_at]
  end

  def item_repo
    ItemRepository.new(@items)
  end
end
