require './lib/merchant_repository'

class Merchant
attr_reader :id, :name, :sales_engine

  def initialize(info, sales_engine = "string")
    @id = info[:id]
    @name = info[:name]
    @sales_engine = sales_engine
  end

  def items(id)
    #return an array of items that share the merchant ID.
    #this will need to communicate with the item repo. 

  end 
end

