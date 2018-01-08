class Merchant
  attr_reader   :id,
                :name,
                :created_at,
                :updated_at

  attr_accessor :item_count, :total_revenue

  def initialize(info, merchant_repository = "")
    @id             = info[:id].to_i
    @name           = info[:name]
    @created_at     = info[:created_at]
    @updated_at     = info[:updated_at]
    @item_count     = 0
    @total_revenue  = 0
    @parent         = merchant_repository
  end

  def items
    @parent.items_by_id(@id)
  end

  def invoices
    @parent.find_invoice_by_merchant_id(@id)
  end

  def customers
    @parent.find_all_customers_by_merchant_id(@id).map do |invoice|
      invoice.customer
    end.uniq
  end

  def downcaser
    @name.downcase
  end
end
