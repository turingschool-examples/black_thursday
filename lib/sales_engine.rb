class SalesEngine
    attr_accessor :paths
  def initialize
    @paths = {}
  end


  def from_csv (hash)
    @paths = hash
    binding.pry
  end

end
