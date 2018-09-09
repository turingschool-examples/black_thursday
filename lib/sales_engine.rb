
class SalesEngine
    attr_reader :data
  def intialize(data)
    @data = data
  end

  def self.from_csv(data)
    new
  end
end
