require_relative 'item'

class ItemRepository

  def initialize(data_file)
    @repository = data_file.map {|item| Item.new(item)}
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
