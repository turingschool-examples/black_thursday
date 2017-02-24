class Merchant
  attr_reader :id, :name, :created_at, :updated_at

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
  end

end
