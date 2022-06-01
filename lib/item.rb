class Item

  attr_reader :id, :name 

  def initialize(item_data)
    @id = item_data[:id]
    @name = item_data[:name]
  end

end
