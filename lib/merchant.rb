class Merchant
  attr_reader :id
  def initialize(hash)
    @id = hash[:id]
  end
end
