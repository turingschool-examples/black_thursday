module Modify
  def create_overall(type, attributes)
    new_type = (type.last.id + 1)
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    attributes[:id] = new_type
    add(attributes)
  end

  def update_overall(type, id, attributes)
    updated_type = find_by_id(id)
    if type == @merchants
      if updated_type != nil
        updated_type.name = attributes[:name]
      end
    elsif type == @items
      if updated_type != nil
        updated_type.name = attributes[:name] if attributes.keys.include?(:name)
        updated_type.description = attributes[:description] if attributes.keys.include?(:description)
        updated_type.unit_price = attributes[:unit_price].to_d if attributes.keys.include?(:unit_price)
        updated_type.updated_at = Time.now
      end
    elsif type == @invoices
      if updated_type != nil
        updated_type.status = attributes[:status].to_sym if attributes.keys.include?(:status)
        updated_type.updated_at = Time.now
      end
    elsif type == @invoice_items
      if updated_type != nil
        updated_type.quantity = attributes[:quantity].to_i if attributes.keys.include?(:quantity)
        updated_type.unit_price = attributes[:unit_price].to_d if attributes.keys.include?(:unit_price)
        updated_type.updated_at = Time.now
      end
    elsif type == @transactions
      if updated_type != nil
        updated_type.credit_card_number = attributes[:credit_card_number] if attributes.keys.include?(:credit_card_number)
        updated_type.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes.keys.include?(:credit_card_expiration_date)
        updated_type.result = attributes[:result] if attributes.keys.include?(:result)
        updated_type.updated_at = Time.now
      end
    end
  end

  def delete_overall(type, id)
      delete_merchant = find_by_id(id)
      type.delete(delete_merchant)
  end
end