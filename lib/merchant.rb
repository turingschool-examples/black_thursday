require 'pry'

class Merchant
  attr_reader   :name, :id
  attr_accessor :engine

  def initialize(merchant_info, engine = nil)
    @name       = merchant_info[:name]
    @id         = merchant_info[:id].to_i
    @engine     = engine
  end

  def items
    engine.items.find_by_id(self.id)
    #connects the merchant with his Etsy shop items by matching Merchant class id
    #with Items class merchant ID
  end




end
