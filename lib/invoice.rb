require 'csv'
require 'bigdecimal'
require 'bigdecimal/util'

class Invoice
attr_reader :id,
            :customer_id,
            :merchant_id,
            :status,
            :created_at,
            :updated_at,
            :repository


  def initialize(data, parent = nil)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = parent
  end


end
