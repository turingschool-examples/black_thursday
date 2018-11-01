class Merchant
  attr_reader :info, :id, :name
  def initialize(info)
    @info = info
    @id = info[:id]
    @name = info[:name]
  end
end
