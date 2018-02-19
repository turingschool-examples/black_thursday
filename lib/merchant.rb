class Merchant
  attr_reader :id, :name, :parent
  def initialize(hash, parent = nil)
    @id   = hash[:id]
    @name = hash[:name]
    @parent = parent
  end
end
