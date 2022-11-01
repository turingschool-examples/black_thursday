module Modify
  def create(attributes)
    if @merchants != [] && @merchants != nil
      new_merchant = (@merchants.last.id + 1)
      @merchants << Merchant.new({
        id: new_merchant,
        name: attributes
      })
    else
      new_item = (@items.last.id + 1)
      @items << Item.new({
        id: new_item,
        name: attributes[:name],
        description: attributes[:description],
        unit_price: attributes[:unit_price],
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: attributes[:merchant_id]
      })
    end
  end

  def update(id, attributes)
    if @merchants != [] && @merchants != nil
      updated_id = find_by_id(id)
      updated_id.name = attributes
    else
      update_item = find_by_id(id)
      # binding.pry
      update_item.name = attributes[:name]
      update_item.description = attributes[:description]
      update_item.unit_price = attributes[:unit_price]
      update_item.updated_at = Time.now
    end
  end

  def delete(id)
    if @merchants != [] && @merchants != nil
      delete_merchant = find_by_id(id)
      @merchants.delete(delete_merchant)
    else
      delete_item = find_by_id(id)
     @items.delete(delete_item)
    end
  end
end