require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(attributes, parent)
    @id           = attributes[:id].to_i
    @customer_id  = attributes[:customer_id].to_i
    @merchant_id  = attributes[:merchant_id].to_i
    @status       = attributes[:status]
    @created_at   = Time.parse(attributes[:created_at])
    @updated_at   = Time.parse(attributes[:updated_at])
    @parent       = parent
  end

  def merchant
    @parent.find_merchant_for_item(self)
  end

  def items
    @parent.find_all_items_by_merchant_id(id)
  end

  def inspect
    "#{self.class} has #{all.count} rows"
  end
end
