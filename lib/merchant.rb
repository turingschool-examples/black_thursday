class Merchant
  attr_reader :id, :name

  def initialize(info)
    @id = info[:id]
    @name = info[:name]
  end

end
