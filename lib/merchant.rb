class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(merchant)
    @id = merchant[:id].to_i
    @name = merchant[:name]
  end
end
