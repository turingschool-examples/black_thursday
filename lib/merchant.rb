class Merchant
  attr_reader :id, :name

  def initialize(stats)
    @id = stats[:id]
    @name = stats[:name]
  end

end
