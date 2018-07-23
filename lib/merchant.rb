class Merchant
  
  attr_accessor :id
  
  attr_reader :name
              
  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
  end
   
end 