class Item
  attr_reader :id,
              :name,
              :description,
              :price,
              :created_at,
              :updated_at
  def initialize(item_hash)
    @item_hash =   @item_hash
    @id =          @item_hash[:id]
    @name =        @item_hash[:name]
    @description = @item_hash[:description]
    @price =       @item_hash[:unit_price]
    @created_at =  @item_hash[:created_at]
    @updated_at =  @item_hash[:updated_at]
  end
end
