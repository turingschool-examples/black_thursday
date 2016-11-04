require_relative 'merchant_repository'
require 'pry'

class Merchant
  attr_reader   :name,
                :id,
                :created_at,
                :updated_at,
                :merchant_parent

  def initialize(merchant_data, parent = nil)
    @merchant_parent = parent
    @name = merchant_data[:name]
    @id = merchant_data[:id].to_i
    @created_at = merchant_data[:created_at]
    @updated_at = merchant_data[:updated_at]
  end

  def items
    merchant_parent.find_all_items_by_merchant(self.id)
  end


end