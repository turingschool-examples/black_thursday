require './lib/item'

class ItemRepository

  def initialize(data_file)
    @repository = data_file.map {|item| Item.new(item)}
  end

end
