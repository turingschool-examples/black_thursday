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

  def average_item_price
    average(sold_items_revenue_hash).round(2)
  end

  def best_item
    hash = sold_items_revenue_hash
    best_item_id = hash.max_by{|k, v| v}[0]
    @merchant_repo.find_item_by_id(best_item_id)
  end

  def items_count
    merchant_items.count
  end

  def invoices_count
    invoice_ids.count
  end

  def items_revenue_hash
    items_quantity_hash.each_with_object({}) do |(item, quantity), hash|
      hash[item] = item.unit_price * quantity
    end
  end

  def items
    @merchant_repo.merchant_items(@id)
  end

  def invoices
    @merchant_repo.merchant_invoices(@id)
  end

  def most_sold_item
    hash = sold_items_quantity_hash
    highest_item_quantity = hash.values.max
    hash.each_with_object([]) do |(invoice_id, quantity), array|
      if quantity == highest_item_quantity
        array << @engine.find_item_by_id(invoice_id)
      end
    end
  end

  def pending_invoices
    invoices.find_all do |invoice|
      invoice.status == (:pending)
    end
  end

  def sold_items_quantity_hash
    @merchant_repo.merchant_sold_item_quantity_hash(@id)
  end

  def sold_items_revenue_hash
    @merchant_repo.merchant_sold_item_revenue_hash(@id)
  end

  def successful_invoices
    @merchant_repo.merchant_successful_invoice_array(@id)
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

  #months/items hash *

end