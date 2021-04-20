class Merchant
  include Mathable
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(row, merchant_repo)
    @id = (row[:id]).to_i
    @name = row[:name]
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @merchant_repo = merchant_repo
  end

  def update(attributes)
    update_name(attributes)
    update_time_stamp
  end

  def update_name(attributes)
    return if attributes[:name].nil?
    @name.replace(attributes[:name])
  end

  def update_time_stamp
    @updated_at = Time.now
  end

  def merchant_items
    @merchant_repo.merchant_items(@id)
  end

  def items_count
    merchant_items.count
  end

  def merchant_invoices
    @merchant_repo.merchant_invoices(@id)
  end

  def invoices_count
    invoice_ids.count
  end

  def merchants_with_pending_invoices
    merchant_invoices.find_all do |invoice|
      invoice.status == (:pending)
    end
  end

  def items_quantity_hash
    merchant_items.each_with_object({}) do |item, hash|
      hash[item] = @merchant_repo.grab_invoice_item(item.id).quantity
    end
  end

  def items_revenue_hash
    items_quantity_hash.each_with_object({}) do |(item, quantity), hash|
      hash[item] = item.unit_price * quantity
    end
  end

  def best_item
    items_quantity_hash.max_by do |item, quantity|
      item.unit_price * quantity
    end
  end

  def average_item_price
    average(items_revenue_hash)
  end

  #pull from MR from Engine From IR the items - put in an instance varibale

  #revenue S
  #months/items hash *
  #most sold item (item with most qty sold)
end