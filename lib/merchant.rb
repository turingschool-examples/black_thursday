class Merchant
  attr_accessor :id,
                :name

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
  end
end
