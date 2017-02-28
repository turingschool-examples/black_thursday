class Merchant
  attr_reader :id, :name, :created_at, :merchant_repository

  def initialize(info = {}, merchant_repository = "")
    @id = info[:id].to_i
    @name = info[:name]
    @created_at = info[:created_at]
    @merchant_repository = merchant_repository
  end

  def created_at
    Time.parse(@created_at)
  end

  def items
    merchant_repository.engine.items.find_all_by_merchant_id(id)
  end

  def invoices
    merchant_repository.engine.invoices.find_all_by_merchant_id(id)
  end
  
  def items_with_invoice_items
    items.select do |item| 
      merchant_repository.engine.invoice_items.find_all_by_item_id(item.id)
    end
  end
  
  def most_sold_items
    items_with_invoice_items.group_by do |item|
      merchant_repository.engine.invoice_items.find_all_by_item_id(item.id).map do |invoice_item|
        invoice_item.quantity
      end
    end
  end
  
  def most_sold_item
    arr = most_sold_items.max_by do |quantity, items|
      quantity
    end[1]
  end

  def customers
    invoices.map { |invoice| invoice.customer_id }.uniq.map do |customer_id|
      merchant_repository.engine.customers.find_by_id(customer_id)
    end
  end

  def any_pending?
    invoices.any? { |invoice| !invoice.is_paid_in_full?}
  end

  def only_one_item?
    items.count == 1
  end

  def revenue
    # if invoices.count == 0
    #   0
    # else
    if invoices.any?
      invoices.select do |invoice|
        invoice.is_paid_in_full?
      end.map {|invoice| invoice.total}.reduce(:+)
    end
  end

  # def most_sold_item
  #   invoice_items.sort_by do |invoice_item|
  #     invoice_item.quantity
  #   end.reverse
  # end

end
