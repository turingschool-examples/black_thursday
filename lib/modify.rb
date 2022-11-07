require_relative 'require_store'

module Modify
  def evaluate
    return Merchant if self.class == MerchantRepository
    return Item if self.class == ItemRepository
    return Invoice if self.class == InvoiceRepository
    return InvoiceItem if self.class == InvoiceItemRepository
    return Transaction if self.class == TransactionRepository
    return Customer if self.class == CustomerRepository
  end

  def create(attributes)
    new_id = (all.last.id + 1)
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    attributes[:id] = new_id
    add(attributes)
  end

  def update(id, attributes)
    updated_instance = find_by_id(id)
    if updated_instance != nil
      updated_instance.updated_at = Time.now
      merchant_update(updated_instance, attributes) if evaluate = Merchant
      item_update(updated_instance, attributes) if evaluate = Item
      invoice_update(updated_instance, attributes) if evaluate = Invoice
      invoice_item_update(updated_instance, attributes) if evaluate = InvoiceItem
      customer_update(updated_instance, attributes) if evaluate = Customer
      transaction_update(updated_instance, attributes) if evaluate = Transaction
    end
  end

  def merchant_update(updated_instance, attributes)
    updated_instance.name = attributes[:name] if attributes.keys.include?(:name)
  end

  def item_update(updated_instance, attributes)
    updated_instance.name = attributes[:name] if attributes.keys.include?(:name)
    updated_instance.description = attributes[:description] if attributes.keys.include?(:description)
    updated_instance.unit_price = attributes[:unit_price].to_d if attributes.keys.include?(:unit_price)
  end

  def invoice_update(updated_instance, attributes)
    updated_instance.status = attributes[:status].to_sym if attributes.keys.include?(:status)
  end

  def invoice_item_update(updated_instance, attributes)
    updated_instance.unit_price = attributes[:unit_price].to_d if attributes.keys.include?(:unit_price)
    updated_instance.quantity = attributes[:quantity].to_i if attributes.keys.include?(:quantity)
  end

  def transaction_update(updated_instance, attributes)
    updated_instance.credit_card_number = attributes[:credit_card_number] if attributes.keys.include?(:credit_card_number)
    updated_instance.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes.keys.include?(:credit_card_expiration_date)
    updated_instance.result = attributes[:result] if attributes.keys.include?(:result)
  end

  def customer_update(updated_instance, attributes)
    updated_instance.first_name = attributes[:first_name] if attributes.keys.include?(:first_name)
    updated_instance.last_name = attributes[:last_name] if attributes.keys.include?(:last_name)
  end

  def delete(id)
      to_be_deleted = find_by_id(id)
      all.delete(to_be_deleted)
  end
end