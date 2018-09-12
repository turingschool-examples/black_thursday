require 'time'

class Invoice
  attr_reader     :id,
                  :customer_id,
                  :created_at,
                  :merchant_id
  attr_accessor   :status,
                  :updated_at

  def initialize(attributes)
    @id = attributes[:id]
    @customer_id = attributes[:customer_id]
    @merchant_id = attributes[:merchant_id]
    @status = attributes[:status]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

end
