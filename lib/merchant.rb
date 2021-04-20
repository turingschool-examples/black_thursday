class Merchant
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

  def item_ids
    merchant_items.map do |item|
      item.id
    end
  end

  def items_quantity_hash
    item_ids.each_with_object({}) do |id, hash|
      hash[id] = @merchant_repo.grab_invoice_item(id).quantity
    end
  end

  # def

  #pull from MR from Engine From IR the items - put in an instance varibale


  #revenue S
  #items/quantity hash !!
  #items/revenue hash
  #avg item price
  #pending invoices S
  #months/items hash *
  #best item (item with most revenue)
  #most sold item (item with most qty sold)


end