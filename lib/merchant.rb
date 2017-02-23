class Merchant
  attr_reader :id,
              :name

  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @parent = parent
  end
  
end