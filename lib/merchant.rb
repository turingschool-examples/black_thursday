class Merchant
  attr_reader :id, :name
  attr_accessor :items

  def initialize(name_id)
    @id = name_id[:id].to_i
    @name = name_id[:name]
    @items
  end

end
