require 'csv'
require_relative '../lib/invoice_repo'
require 'pry'
require 'time'

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

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def merchant
    @parent.merchants.find_by_id(merchant_id)
  end

end
