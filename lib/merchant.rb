require_relative '../lib/item_repo'
class Merchant
  attr_reader :id,
              :name,
              :parent

  def initialize(merchant_details, merchant_repo = nil)
    @id   = merchant_details[:id].to_i
    @name = merchant_details[:name]
    @parent = merchant_repo
  end

  def items
    @parent.find_all_items_by_merchant_id(self.id)
  end

  def invoices
    @parent.find_invoices_by_merchant_id(self.id)
  end

  def customers 
    invoices = @parent.find_invoices_by_merchant_id(id)
    invoices.map do |invoice|
      @parent.find_customer_by_customer_id(invoice.customer_id)
    end
  end
end


