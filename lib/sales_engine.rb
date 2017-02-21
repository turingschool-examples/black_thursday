class SalesEngine
    attr_accessor :paths
  def initialize
    @paths = {}
  end


  def from_csv (hash)
    files = hash.each_pair do |key, value|
      @paths[key] = value
    end
    files
  end

end
