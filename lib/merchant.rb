# documentation
class Merchant
# frozen_string_literal: true
  attr_reader :id,
              :parent
  attr_accessor :name,
                :created_at,
                :updated_at

  def initialize(params, parent)
    @id         = params[:id].to_i
    @name       = params[:name]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
    @parent     = parent
  end

  def items
    parent.find_all_items_by_merchant_id(id)
  end

  def invoices
    parent.find_all_invoices_by_merchant_id(id)
  end

  def customers
    parent.find_customers_of_merchant_id(id)
  end
end
