class Item

  attr_reader :id, :name, :description 

  def initialize(item_data)
    @id = item_data[:id]
    @name = item_data[:name]
    @description = item_data[:description]
  end

end
