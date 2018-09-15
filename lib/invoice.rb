require 'csv'
require 'bigdecimal'
require 'time'


class Invoice
  attr_reader :id,
              :created_at

  attr_accessor :customer_id,
                :merchant_id,
                :status,
                :updated_at


  def initialize(sale_stats)
    @sale_stats = {}
    @id = sale_stats[:id]
    @customer_id = sale_stats[:customer_id]
    @merchant_id = sale_stats[:merchant_id]
    @status = sale_stats[:status]
    @created_at = sale_stats[:created_at]
    @updated_at = sale_stats[:updated_at]
  end


end
