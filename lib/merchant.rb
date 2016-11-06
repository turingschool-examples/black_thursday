require 'csv'
require_relative '../lib/merchant_repo'
require 'bigdecimal'
require 'pry'

class Merchant
  attr_reader :parent,
              :id,
              :name,
              :created_at,
              :updated_at
              
  def initialize(data, repo)
      @parent = repo
      @id = data[:id].to_i
      @name = data[:name].to_s
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end

   def items
    @parent.find_all_by_merchant_id(id)
  end

  def invoices
    @parent.find_all_invoices_by_id(id)
  end

  def num_items
    items.length
  end

  def num_invoices
    invoices.length
  end
  
end