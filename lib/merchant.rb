class Merchant

  attr_reader :id, :name

  def initialize(attributes)
    @id   = attributes[:id]
    @name = attributes[:name]
  end

  def info
    {
      id: id,
      name: name
    }
  end
end
