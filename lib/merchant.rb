class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(stats)
    @id = stats[:id].to_i
    @name = stats[:name]
  end

end
