class SalesEngine
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end
end
