module Modify
  def create(attributes)
    if @merchants != [] && @merchants != nil
      new_merchant = (@merchants.last.id + 1)
      @merchants << Merchant.new({
        id: new_merchant,
        name: attributes[:name]
      })
    elsif @items != [] && @items != nil
      new_item = (@items.last.id + 1)
      @items << Item.new({
        id: new_item,
        name: attributes[:name],
        description: attributes[:description],
        unit_price: attributes[:unit_price],
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s,
        merchant_id: attributes[:merchant_id]
      })
    else
      new_invoice = (@invoices.last.id + 1)
      @invoices << Invoice.new({
        id: new_invoice,
        customer_id: attributes[:customer_id],
        merchant_id: attributes[:merchant_id],
        status: attributes[:status],
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s
        })
    end
  end

  def update(id, attributes)
    if @merchants != [] && @merchants != nil
      updated_merchant = find_by_id(id)
      if updated_merchant != nil
        updated_merchant.name = attributes[:name]
      end
    elsif @items != [] && @items != nil
      update_item = find_by_id(id)
      if update_item != nil
        update_item.name = attributes[:name] if attributes.keys.include?(:name)
        update_item.description = attributes[:description] if attributes.keys.include?(:description)
        update_item.unit_price = attributes[:unit_price] if attributes.keys.include?(:unit_price)
        update_item.updated_at = Time.now
      end
    else
      update_invoice = find_by_id(id)
      if update_invoice != nil
        update_invoice.status = attributes[:status].to_sym if attributes.keys.include?(:status)
        update_invoice.updated_at = Time.now
      end
    end
  end

  def delete(id)
    if @merchants != [] && @merchants != nil
      delete_merchant = find_by_id(id)
      @merchants.delete(delete_merchant)
    elsif @items != [] && @items != nil
      delete_item = find_by_id(id)
      @items.delete(delete_item)
    else
      delete_invoice = find_by_id(id)
      @invoices.delete(delete_invoice)
    end
  end
end