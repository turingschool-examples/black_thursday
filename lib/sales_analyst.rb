class SalesAnalyst

  attr_reader :engine

  def initialize(engine)
    @engine = engine
    require 'pry'; binding.pry 
  end
end
