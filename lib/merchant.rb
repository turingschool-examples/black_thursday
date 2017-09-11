class Merchant 
  attr_reader :id, :name 

  def initialize(item)
    @item = item 
    @id   = item[:id]
    @name = item[:name]
  end
end