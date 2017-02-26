require 'pry'
class Merchant
  attr_reader :id, :name, :merchant_repository

  def initialize(info = {}, merchant_repository = "")
    @id = info[:id].to_i
    @name = info[:name]
    @merchant_repository = merchant_repository
  end

  def items
    merchant_repository.engine.items.find_all_by_merchant_id(id)
  end

end
