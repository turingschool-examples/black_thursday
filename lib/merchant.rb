require 'pry'

class Merchant
  attr_reader   :name, :id
  attr_accessor :items

  def initialize(merchant_info, items_repo = nil)
    @name       = merchant_info[:name]
    @id         = merchant_info[:id].to_i
    @items_repo = items_repo
  end

  def items
    @items_repo.find_all_by_merchant_id(merchant.id)
    #connects the merchant with his Etsy shop items by matching Merchant class id
    #with Items class merchant ID
  end




end
