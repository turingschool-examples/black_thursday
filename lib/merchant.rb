
class Merchant
  attr_reader :id, :name

  def initialize(info)
    @name = info[:name]
    @id = info[:id]
  end

end
