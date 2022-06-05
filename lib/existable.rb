require 'helper'

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
  #
  # def make_new_repo(file_path)
  #   repo = Array.new
  #   make_new = Proc.new {|row| repo << evaluate.new(row)}
  #   parse_csv = lambda {CSV.foreach(file_path, headers: true, header_converters: :symbol)}
  #   parse_csv.call(&make_new)
  #   repo
  # end
  #
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
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }))
  end

  def  make_customer(attributes)
    @all.push(Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }))
  end
  #
  # def update_thing(id, attributes)
  #   to_be_updated = find_by_id(id)
  #   to_be_updated.updated_at = (Time.now).strftime("%Y-%m-%d %H:%M")
  #   case self.class
  #   when MerchantRepository || ItemRepository
  #     to_be_updated.name = attributes
  #   when ItemRepository
  #     to_be_updated.description = attributes[:description]
  #     to_be_updated.unit_price = attributes[:unit_price]
  #   when InvoiceRepository
  #     to_be_updated.status = attributes
  #   else
  #     return
  #   end
  # end

  def delete(id)
    to_be_dropped = find_by_id(id)
    @all.delete(to_be_dropped)
    @all.find_by_id(id) == nil ? 'Deletion complete!' : '...something went wrong'
  end
end
