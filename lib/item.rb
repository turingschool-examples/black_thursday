class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(item_data, item_repo)
    @item_repo = item_repo
    @id = item_data[:id].to_i
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = BigDecimal.new(item_data[:unit_price],4)
    @created_at = item_data[:created_at]
    @updated_at = item_data[:updated_at]
    @merchant_id = item_data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price
  end

  def merchant
    @item_repo.sales_engine.merchant.find_by_id(@merchant_id)
  end

end
