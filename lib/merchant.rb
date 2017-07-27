class Merchant
  attr_reader :id,
              :name
  def initialize(data, mr = nil)
    @mr = mr
    @id = data[:id]
    @name = data[:name]
  end

  def items
    require "pry"; binding.pry
    @mr.fetch_items(merchant.id)
  end

end
