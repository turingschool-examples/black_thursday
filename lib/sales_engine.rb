class SalesEngine
    attr_accessor :paths
  def initialize (hash)
    @paths = hash
  end


  def self.from_csv(hash)
    files = hash.each_pair do |key, value|
      @paths[key] = value
    end
    SalesEngine.new(files)
  end

end
