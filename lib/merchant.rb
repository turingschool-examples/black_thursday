class Merchant
  attr_reader :id,
              :name
  def initialize(data, mr = nil)
    @mr = mr
    @id = data[:id]
    @name = data[:name]
  end

  def items
    @mr.fetch_items(id)
  end

end
