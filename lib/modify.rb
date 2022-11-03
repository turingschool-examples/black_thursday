module Modify
  def create_overall(type, attributes)
    new_type = (type.last.id + 1)
    if type == @merchants
      @merchants << Merchant.new({
        id: new_type,
        name: attributes[:name]
      })
    elsif type == @items
      @items << Item.new({
        id: new_type,
        name: attributes[:name],
        description: attributes[:description],
        unit_price: attributes[:unit_price],
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s,
        merchant_id: attributes[:merchant_id]
      })
    elsif type == @invoices
      @invoices << Invoice.new({
        id: new_type,
        customer_id: attributes[:customer_id],
        merchant_id: attributes[:merchant_id],
        status: attributes[:status],
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s
        })
    elsif type == @invoice_items
      @invoice_items << InvoiceItem.new({
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

  def delete_overall(type, id)
      delete_merchant = find_by_id(id)
      type.delete(delete_merchant)
  end
end