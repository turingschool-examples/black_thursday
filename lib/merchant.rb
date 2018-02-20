require 'pry'
require_relative '../lib/merchant_repository'
class Merchant
  attr_reader :id,
              :name
  def initialize(data)
    @id   = data[:id].to_i
    @name = data[:name]
  end

  def items
    @engine.items.find_all_by_merchant_id(@id)
  end
end
