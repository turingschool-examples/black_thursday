require 'pry'
require 'csv'

class Merchant
  attr_reader :id,
              :name,
              :parent

  def initialize(hash, merchant_repository_instance = nil)
    @id     = hash[:id]
    @name   = hash[:name]
    @parent = merchant_repository_instance
  end

  def items(id)
    @parent.find_items_by_merchant_id
  end
end
