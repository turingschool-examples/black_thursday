
class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
  end
end
