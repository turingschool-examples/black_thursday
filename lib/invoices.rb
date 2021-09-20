# frozen_string_literal: true
require 'csv'
require_relative './sales_engine'

class Invoice
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :created_at
  attr_accessor :status,
                :updated_at
  def initialize(data)
    @id          = data[0].to_i
    @customer_id = data[1].to_i
    @merchant_id = data[2].to_i
    @status      = data[3].to_sym
    @created_at  = Time.parse(data[4])
    @updated_at  = Time.parse(data[5])
  end
end
