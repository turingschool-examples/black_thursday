require 'time'

class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(merchant_info = nil, repo = nil)
    return if merchant_info.to_h.empty?
    @parent      = repo
    @id          = merchant_info[:id].to_i
    @name        = merchant_info[:name].to_s
    @created_at  = make_time_object(merchant_info[:created_at])
    @updated_at  = make_time_object(merchant_info[:updated_at])
  end

  def make_time_object(time)
    Time.parse(time.to_s) if time
  end

  def items
    parent.find_items_by_merchant_id(id)
  end

  def invoices
    parent.find_invoices(id)
  end

  def customers
    parent.find_customers_of_merchant(id)
  end

end