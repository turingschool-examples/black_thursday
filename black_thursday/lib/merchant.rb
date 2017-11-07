require 'time'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(attributes, parent =
    MerchantRepository.new("./test/fixtures/truncated_merchants.csv"))
    @id         = attributes[:id].to_i
    @name       = attributes[:name]
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    @parent     = parent
  end

  def items
    @parent.find_all_items_by_merchant_id(id)
  end

  def invoices
    parent.find_invoices_by_merchant(id)
  end

  def customers
    parent.find_customer_by_merchant_id(id)
  end
end
