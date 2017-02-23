class Merchant
  attr_reader :id, :name, :engine

  def initialize(info = {}, merchant_repository = "")
    @id = info[:id]
    @name = info[:name]
    @engine = engine
  end
end
