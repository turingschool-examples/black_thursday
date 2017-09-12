class Merchant 
  attr_reader :id, :name 

  def initialize(item)
    @item = item 
    @id   = item[:id].to_i
    @name = item[:name]
  end
end