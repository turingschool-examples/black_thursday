class Merchant
  attr_accessor :name
  attr_reader :id

  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
  end
end
