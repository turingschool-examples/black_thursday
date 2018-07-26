# frozen_string_literal: true
require 'pry'
# ./lib/invoice
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at
  attr_accessor :status,
                :updated_at

  @@max_merchant_id = 0

  def initialize(attributes)
    @id = attributes[:id].to_i unless attributes[:id].nil? 
    @id = (@@max_merchant_id += 1) if attributes[:id].nil?
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status = attributes[:status].to_sym
    @created_at = Time.new(attributes[:created_at].to_s)
    @updated_at = Time.new(attributes[:updated_at].to_s)
    update_max_id
  end

  def update_max_id
    @@max_merchant_id = @id if @id > @@max_merchant_id
  end
end
