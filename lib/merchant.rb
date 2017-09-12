require 'merchant_repository'

class Merchant
attr_reader :id, :name

  def initialize(info = {})
    @id = info[:id]
    @name = info[:name]
  end

  def items(id)
    #return an array of items that share the merchant ID.
    #this will need to communicate with the item repo. 

  end 
end

