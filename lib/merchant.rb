class Merchant

  attr_accessor :id, :name

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
  end

end
