class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :item_repo

  def initialize(info, item_repo)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id]
    @item_repo = item_repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
