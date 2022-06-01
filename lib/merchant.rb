class Merchant
  attr_reader :info
  def initialize(info)
    @info = info
  end

  def id
    @info[:id]
  end

  def name
    @info[:name]
  end

end
