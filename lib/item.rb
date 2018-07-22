class Item
  attr_reader :name,
              :description

  def initialize(item_hash)
    @name = item_hash[:name]
    @description = item_hash[:description]
  end
end
