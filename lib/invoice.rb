require 'csv'
require './lib/invoice_repo'
require 'pry'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, repo)
      @parent = repo
      @id = data[:id].to_i
      @customer_id = data[:customer_id]
      @merchant_id = data[:merchant_id]
      @status = data[:status]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end

  
end