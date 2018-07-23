class Merchant

  attr_accessor :id, :name

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
  end

end
