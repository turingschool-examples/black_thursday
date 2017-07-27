class Merchant
  attr_reader :id,
              :name
  def initialize(data, mr = nil)
    @mr = mr
    @id = data[:id]
    @name = data[:name]
  end

  def item
   @mr.item(item_id)
  end

end
