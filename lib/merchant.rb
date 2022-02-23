class Merchant
  attr_reader :id, :name
  def initialize(details)
    @id = details[:id]
    @name = details[:name]
  end
end
