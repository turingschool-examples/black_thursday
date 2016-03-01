class Merchant
  def initialize(info_hash)
    @info = info_hash
  end

  def id
    @info[:id]
  end

  def name
    @info[:name]
  end
end