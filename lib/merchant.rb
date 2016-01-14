require 'pry'

class Merchant
  attr_reader :name, :id, :items_repo

  def initialize(merchant_info, items_repo = nil)
    @name       = merchant_info[:name]
    @id         = merchant_info[:id]
    @items_repo = items_repo
  end

  def items
    items_repo.find_all_by_merchant_id(id)
  end


end
