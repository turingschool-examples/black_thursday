module Modify
  def create_overall(type, attributes)
    new_type = (type.last.id + 1)
    if type == @merchants
      add({
        id: new_type,
        name: attributes[:name]
      })
    elsif type == @items
      add({
        id: new_type,
        name: attributes[:name],
        description: attributes[:description],
        unit_price: attributes[:unit_price],
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s,
        merchant_id: attributes[:merchant_id]
      })
    elsif type == @invoices
      add({
        id: new_type,
        customer_id: attributes[:customer_id],
        merchant_id: attributes[:merchant_id],
        status: attributes[:status],
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s
        })
    elsif type == @invoice_items
      add({
        id: new_type,
        item_id: attributes[:item_id],
        invoice_id: attributes[:invoice_id],
        quantity: attributes[:quantity],
        unit_price: attributes[:unit_price],
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s
        })
    end
  end

  def update_overall(type, id, attributes)
    updated_type = find_by_id(id)
    if type = @merchants
      if updated_type != nil
        updated_type.name = attributes[:name]
      end
    elsif type = @items
      if updated_type != nil
        updated_type.name = attributes[:name] if attributes.keys.include?(:name)
        updated_type.description = attributes[:description] if attributes.keys.include?(:description)
        updated_type.unit_price = attributes[:unit_price].to_d / 100 if attributes.keys.include?(:unit_price)
        updated_type.updated_at = Time.now
      end
    elsif type = @invoices
      if updated_type != nil
        updated_type.status = attributes[:status].to_sym if attributes.keys.include?(:status)
        updated_type.updated_at = Time.now
      end
    elsif type = @invoice_items
      if updated_type != nil
        updated_type.quantity = attributes[:quantity].to_i if attributes.keys.include?(:quantity)
        updated_type.unit_price = attributes[:unit_price].to_d / 100 if attributes.keys.include?(:unit_price)
      end
    end
  end

  def delete_overall(type, id)
      delete_merchant = find_by_id(id)
      type.delete(delete_merchant)
  end
end