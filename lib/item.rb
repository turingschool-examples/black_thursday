class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at
  def initialize(item_hash, item_repository)
    @item_hash =       item_hash
    @item_repository = item_repository
    @id =              @item_hash[:id]
    @name =            @item_hash[:name]
    @description =     @item_hash[:description]
    @unit_price =      @item_hash[:unit_price]
    @merchant_id =     @item_hash[:merchant_id]
    @created_at =      @item_hash[:created_at]
    @updated_at =      @item_hash[:updated_at]
  end

  def merchant
    @item_repository.find_mechant(@merchant_id)
  end
end
