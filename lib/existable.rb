require_relative 'helper'

module Existable
  def get_time
    Time.now.strftime("%Y-%m-%d %H:%M")
  end

  def create(attribute)
    return make_merchant(attribute) if self.class == MerchantRepository
    return make_item(attribute) if self.class == ItemRepository
    return make_invoice(attribute) if self.class == InvoiceRepository
    return make_invoice_item(attribute) if self.class == InvoiceItemRepository
    return make_transaction(attribute) if self.class == TransactionRepository
    return make_customer(attribute) if self.class == CustomerRepository
  end

  def max_id
    (@all.max_by {|thing| thing.id}).id
  end

  def make_merchant(attribute)
    @all.push(Merchant.new({
      :id => max_id + 1,
      :name => attribute
    }))
  end

  def  make_item(attribute)
     @all.push(Item.new({
      :id => max_item_id + 1,
      :name => name,
      :description => description,
      :unit_price => price,
      :created_at => get_time,
      :updated_at => get_time,
      :merchant_id => merchantID
    }))
  end

  def  make_invoice(attribute)
    self.all.push(Invoice.new({
      :id          => max_id + 1,
      :customer_id => attributes[:customer_id],
      :merchant_id => attributes[:merchant_id],
      :status      => attributes[:status],
      :created_at  => get_time,
      :updated_at  => get_time,
    }))
  end

  def make_invoice_item(attribute)
    self.all.push(InvoiceItem.new({
      :id => max_id + 1,
      :item_id => attributes[:item_id],
      :invoice_id => attributes[:invoice_id],
      :quantity => attributes[:quantity],
      :unit_price => attributes[:unit_price],
      :created_at => get_time,
      :updated_at => get_time
    }))
  end

  def make_transaction(attribute)
    @all.push(Transaction.new({
      :id => max_id + 1,
      :invoice_id => attributes[:invoice_id],
      :credit_card_number => attributes[:credit_card_number],
      :credit_card_expiration_date => attributes[:credit_card_expiration_date],
      :result => attributes[:result],
      :created_at => get_time,
      :updated_at => get_time
    }))
  end

  def  make_customer(attribute)
    @all.push(Customer.new({
      :id => max_id + 1,
      :first_name => attributes[:first_name],
      :last_name => attributes[:last_name],
      :created_at => get_time,
      :updated_at => get_time
    }))
  end

  def evaluate
    return Merchant if self.class == MerchantRepository
    return Item if self.class == ItemRepository
    return Invoice if self.class == InvoiceRepository
    return InvoiceItem if self.class == InvoiceItemRepository
    return Transaction if self.class == TransactionRepository
    return Customer if self.class == CustomerRepository
  end

  def update(id, attributes)
    self.class.ancestors.include?(Repository) ? to_be_updated = find_by_id(id) : to_be_updated = self
    update_what(to_be_updated, attributes)
  end

  def updated_time
    self.updated_at = get_time
  end

  def update_what(to_be_updated, attributes)
    return update_merchant(to_be_updated, attributes) if self.class == Merchant || evaluate == Merchant
    return update_item(to_be_updated, attributes) if  self.class == Item || evaluate == Item
    return update_invoice(to_be_updated, attributes) if self.class == Invoice || evaluate == Invoice
    return update_invoice_item(to_be_updated, attributes) if self.class == InvoiceItem || evaluate == InvoiceItem
    return update_transaction(to_be_updated, attributes) if self.class == Transaction || evaluate == Transaction
    return update_customer(to_be_updated, attributes) if self.class == Customer || evaluate == Customer
  end

  def update_merchant(to_be_updated, attributes)
    to_be_updated.name = attributes
  end

  def update_item(to_be_updated, attributes)
    to_be_updated.name = attributes
    to_be_updated.description = attributes[:description]
    to_be_updated.unit_price = attributes[:unit_price]
    updated_time
  end

  def update_invoice(to_be_updated, attributes)
    to_be_updated.status = attributes
    updated_time
  end

  def update_invoice_item(to_be_updated, attributes)
    to_be_updated.quantity = attributes[:quantity]
    to_be_updated.unit_price = attributes[:unit_price]
    updated_time
  end

  def update_transaction(to_be_updated, attributes)
    to_be_updated.credit_card_number = attributes[:credit_card_number]
    to_be_updated.credit_card_expiration_date = attributes[:credit_card_expiration_date]
    updated_time
  end

  def update_customer(to_be_updated, attributes)
    to_be_updated.first_name = attributes[:first_name]
    to_be_updated.last_name = attributes[:last_name]
    updated_time
  end

  def delete(id)
    to_be_dropped = @all.find {|thing| thing.id == id}
    @all.delete(to_be_dropped)
    to_be_dropped == nil ? 'Deletion complete!' : '...something went wrong'
  end
end
