class Item
  attr_reader :id

  def initialize(item_data)
    @id = item_data[:id]
  end


end
