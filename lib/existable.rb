require_relative 'helper'

module Existable

  def evaluate
    if self.class == MerchantRepository
      return Merchant
    elsif self.class == ItemRepository
      return Item
    elsif self.class == InvoiceRepository
      return Invoice
    elsif self.class == InvoiceItemRepository
      return InvoiceItem
    elsif self.class == CustomerRepository
      return Customer
    else self.class == TransactionRepository
      return Transaction
    end
  end

  def max_id
    (@all.max_by {|thing| thing.id}).id
  end

  def make_merchant(name)
    @all.push(Merchant.new({
      :id => max_id + 1,
      :name => name
    }))
  end

  def  make_item(attributes)
     @all.push(Item.new({
      :id => max_item_id + 1,
      :name => name,
      :description => description,
      :unit_price => price,
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => merchantID
    }))
  end

  def  make_invoice(attributes)
    self.all.push(Invoice.new({
      :id          => max_id + 1,
      :customer_id => attributes[:customer_id],
      :merchant_id => attributes[:merchant_id],
      :status      => attributes[:status],
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }))
  end

  def make_invoice_item(attributes)
    self.all.push(InvoiceItem.new({
      :id => max_id + 1,
      :item_id => attributes[:item_id],
      :invoice_id => attributes[:invoice_id],
      :quantity => attributes[:quantity],
      :unit_price => attributes[:unit_price],
      :created_at => Time.now,
      :updated_at => Time.now
    }))
  end

  def make_transaction(attributes)
    @all.push(Transaction.new({
      :id => max_id + 1,
      :invoice_id => attributes[:invoice_id],
      :credit_card_number => attributes[:credit_card_number],
      :credit_card_expiration_date => attributes[:credit_card_expiration_date],
      :result => attributes[:result],
      :created_at => Time.now,
      :updated_at => Time.now
    }))
  end

  def  make_customer(attributes)
    @all.push(Customer.new({
      :id => max_id + 1,
      :first_name => attributes[:first_name],
      :last_name => attributes[:last_name],
      :created_at => Time.now,
      :updated_at => Time.now
    }))
  end

  def update(id, attributes)
    to_be_updated = find_by_id(id)
    # require "pry"; binding.pry
    to_be_updated.updated_at = (Time.now).strftime("%Y-%m-%d %H:%M")
    if evaluate == MerchantRepository
      to_be_updated.name = attributes
    elsif evaluate == ItemRepository
      to_be_updated.name = attributes
      to_be_updated.description = attributes[:description]
      to_be_updated.unit_price = attributes[:unit_price]
    elsif evaluate == InvoiceRepository
      to_be_updated.status = attributes
    elsif evaluate == InvoiceItemRepository
      to_be_updated.quantity = attributes[:quantity]
      to_be_updated.unit_price = attributes[:unit_price]
    elsif evaluate == Transaction
      to_be_updated.credit_card_number = attributes[:credit_card_number]
      to_be_updated.credit_card_expiration_date = attributes[:credit_card_expiration_date]
    elsif evaluate == Customer
      to_be_updated.first_name = attributes[:first_name]
      to_be_updated.last_name = attributes[:last_name]
    else
      return
    end
  end

  def delete(id)
    to_be_dropped = find_by_id(id)
    @all.delete(to_be_dropped)
    @all.find_by_id(id) == nil ? 'Deletion complete!' : '...something went wrong'
  end
end
