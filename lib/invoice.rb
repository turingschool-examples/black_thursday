require_relative 'invoice_repository'
require 'pry'
require 'csv'
require_relative 'sanitize'

class Invoice
include Sanitize
  attr_reader :id, 
              :customer_id, 
              :merchant_id,  
              :created_at, 
              :updated_at,
              :status

  def initialize(info)
    @id = info[:id].to_i
    @customer_id = info[:customer_id].to_i
    @merchant_id = info[:merchant_id].to_i
    @status = info[:status].to_sym
    @created_at = to_time(info[:created_at])
    @updated_at = to_time(info[:updated_at])
  end

  def update(attributes)
    @status = attributes[:status] if attributes[:status]
    @updated_at = Time.now
    self
  end

end