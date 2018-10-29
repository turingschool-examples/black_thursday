class Item
  attr_reader :id, :name, :description
  def initialize(info)
    @id = info[:id]
    @name = info[:name]
    @description = info[:description]
  end

end
