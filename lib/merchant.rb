class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(stats)
    @id = stats[:id]
    @name = stats[:name]
  end

end
