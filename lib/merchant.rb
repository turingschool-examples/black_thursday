class Merchant
  attr_reader :info, :id, :name
  def initialize(info)
    @info = info
    @id = info[:id]
    @name = info[:name]
  end

  def update(info)
    @id = info[:id] if info[:id]
    @name = info[:name] if info[:name]
  end

end
